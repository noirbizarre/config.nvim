#!/usr/bin/env -S uv run --script
#
# /// script
# requires-python = ">=3.14"
# dependencies = [
#     "httpx>=0.28.1",
#     "rich>=14.2.0",
# ]
# ///
import csv
import json
import sys
from contextlib import contextmanager
from dataclasses import asdict, dataclass, fields
from pathlib import Path
from typing import TYPE_CHECKING, Self

import httpx
import rich.traceback
from rich.console import Console
from rich.progress import (
    BarColumn,
    DownloadColumn,
    Progress,
    SpinnerColumn,
    TransferSpeedColumn,
)

if TYPE_CHECKING:
    from collections.abc import Iterator

console = Console()
error_console = Console(stderr=True)

rich.traceback.install(
    console=error_console,
    width=None,
    suppress=[sys.exec_prefix, sys.base_exec_prefix],
)


OK = "[green]✔[/]"
KO = "[red]✘[/]"

UNICODE_VERSION = "17.0.0"
BASE_URL = f"https://www.unicode.org/Public/{UNICODE_VERSION}/"
BLOCKS_URL = BASE_URL + "ucd/Blocks.txt"
DATA_URL = BASE_URL + "ucd/UnicodeData.txt"
OUTPUT = Path(__file__).parent / "unicode.json"

CATEGORIES: dict[str, list[str | tuple[int, int]]] = {
    "Currencies": ["Currency Symbols"],
    "Symbols": [
        "Dingbats",
        "Miscellaneous Symbols",
        "Miscellaneous Technical",
    ],
    "Games": [
        "Domino Tiles",
        "Mahjong Tiles",
        "Playing Cards",
        "Chess Symbols",
    ],
    "Maths": [
        "Mathematical Operators",
        "Miscellaneous Mathematical Symbols-A",
        "Miscellaneous Mathematical Symbols-B",
        "Supplemental Mathematical Operators",
        "Mathematical Alphanumeric Symbols",
        "Arabic Mathematical Alphabetic Symbols",
        "Letterlike Symbols",
    ],
    "Boxes & Lines": [
        "Block Elements",
        "Box Drawing",
    ],
    "Arrows": [
        "Miscellaneous Symbols and Arrows",
        "Supplemental Arrows-A",
        "Supplemental Arrows-B",
        "Supplemental Arrows-C",
    ],
}


@dataclass
class Glyph:
    """
    Glyph representation from UnicodeData.txt
    """

    codepoint: str
    name: str
    category: str
    combining: str
    bidi_class: str
    decomposition: str
    decimal_digit: str
    digit: str
    numeric: str
    mirrored: str
    unicode_1_name: str
    iso_comment: str
    simple_uppercase_mapping: str
    simple_lowercase_mapping: str
    simple_titlecase_mapping: str

    def __rich__(self) -> str:
        return f"{self.icon} U+{self.codepoint:04X} {self.name} ({self.category})"

    @property
    def index(self) -> int:
        return int(self.codepoint, 16)

    @property
    def icon(self) -> str:
        return chr(self.index)


@dataclass
class Category:
    name: str
    ranges: list[tuple[int, int]]

    def __contains__(self, glyph: Glyph) -> bool:
        return any(start <= glyph.index <= end for start, end in self.ranges)

    @classmethod
    def from_specs(
        cls,
        name: str,
        blocks: dict[str, tuple[int, int]],
        names_ranges: list[str | tuple[int, int]],
    ) -> Self:
        ranges = []
        for name_or_range in names_ranges:
            if isinstance(name_or_range, str):
                ranges.append(blocks[name_or_range])
            else:
                ranges.append(name_or_range)
        return cls(name, ranges)


@dataclass
class Icon:
    """
    Icon format expected by Snacks picker
    See: https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#icons
    """

    icon: str
    name: str
    category: str


def success(message: str) -> None:
    console.print(f"{OK} {message}")


def error(message: str) -> None:
    error_console.print(f"{KO} {message}")


def path(path: Path) -> str:
    rel = path
    if path.is_relative_to(Path().absolute()):
        rel = str(path.relative_to(Path().absolute()))
    elif path.is_relative_to(Path.home()):
        rel = str(path).replace(str(Path.home()), "~")
    return f"[purple]{rel}[/]"


@contextmanager
def progress_with_speed() -> Iterator[Progress]:
    with Progress(
        SpinnerColumn(finished_text=OK),
        "[progress.description]{task.description} [progress.percentage]{task.percentage:>3.0f}%",
        BarColumn(bar_width=None),
        DownloadColumn(),
        TransferSpeedColumn(),
    ) as progress:
        yield progress


def download(url: str, message: str | None = None) -> str:
    out = ""
    with (
        progress_with_speed() as progress,
        httpx.stream("GET", url) as response,
    ):
        total = int(response.headers.get("Content-Length", 0))
        task = progress.add_task(message or f"Downloading {url}", total=total)

        for chunk in response.iter_text():
            out += chunk
            progress.update(task, completed=response.num_bytes_downloaded)
    return out


def load_blocks() -> dict[str, tuple[int, int]]:
    blocks = {}
    for line in download(BLOCKS_URL, "Loading [cyan]blocks[/]").splitlines():
        line = line.strip()
        if not line or line.startswith("#"):
            continue
        range_part, name_part = line.split(";")
        range_part = range_part.strip()
        name_part = name_part.strip()
        start_str, end_str = range_part.split("..")
        start = int(start_str, 16)
        end = int(end_str, 16)
        blocks[name_part] = (start, end)
    return blocks


def load_glyphs() -> list[Glyph]:
    return [
        Glyph(**row)
        for row in csv.DictReader(
            download(DATA_URL, "Loading [cyan]data[/]").splitlines(),
            delimiter=";",
            fieldnames=[field.name for field in fields(Glyph)],
        )
    ]


def build_categories(blocks: dict[str, tuple[int, int]]) -> list[Category]:
    return [
        Category.from_specs(name, blocks, names_ranges) for name, names_ranges in CATEGORIES.items()
    ]


blocks = load_blocks()
with console.status("Building [cyan]categories[/]..."):
    categories = build_categories(blocks)
success("Built [cyan]categories[/]")
glyphs = load_glyphs()
icons = []

with console.status("Building [cyan]icons[/]..."):
    icons = [
        Icon(
            icon=glyph.icon,
            name=glyph.name.lower(),
            category=category.name,
        )
        for glyph in glyphs
        for category in categories
        if glyph in category
    ]

with console.status(f"Writing to {path(OUTPUT)}..."):
    OUTPUT.write_text(
        json.dumps([asdict(icon) for icon in icons], ensure_ascii=False, indent=2),
        encoding="utf-8",
    )

success(f"{path(OUTPUT)} generation complete")
