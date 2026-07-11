--- Helpers to create human-readable, browsable Snacks scratch notes.
---
--- Snacks hard-codes the on-disk scratch filename as an 8-char sha256 hash, so
--- notes are not recognizable when browsing the folder outside Neovim. Passing
--- an explicit `file` to `Snacks.scratch.open()` bypasses this and lets us use
--- a readable filename. Since Snacks only reads (never creates) the sidecar
--- `.meta` for an explicit file, and `Snacks.scratch.list()` enumerates
--- `*.meta` files, we write the meta ourselves so named notes still show up in
--- `Snacks.scratch.select()`.

local git = require("lib.git")

local M = {}

--- Last opened note, persisted in an ALL-UPPERCASE global so Neovim's native
--- `:mksession` (via persistence.nvim, `sessionoptions` contains `globals`)
--- saves and restores it across sessions. Stored JSON-encoded because session
--- globals may only be strings or numbers.
local STATE_GLOBAL = "LAST_SCRATCH_NOTE"

--- Read the persisted last note (nil when unset or corrupt).
---@return { file: string, name: string, ft: string }?
local function get_last()
    local raw = vim.g[STATE_GLOBAL]
    if type(raw) ~= "string" or raw == "" then
        return nil
    end
    local ok, note = pcall(vim.json.decode, raw)
    if ok and type(note) == "table" and note.file then
        return note
    end
    return nil
end

--- Slugify a free-form note name into a safe filename stem.
---@param name string
---@return string
local function slug(name)
    local s = name:lower():gsub("[^%w%-_]+", "-"):gsub("^%-+", ""):gsub("%-+$", "")
    return s ~= "" and s or "note"
end

--- Record the last-opened note. Persisted via a session global so it survives
--- a session restore.
---@param note { file: string, name: string, ft: string }
function M.remember(note) vim.g[STATE_GLOBAL] = vim.json.encode({ file = note.file, name = note.name, ft = note.ft }) end

--- Toggle a scratch note for the current project, in order of preference:
---  1. the last-opened note (persisted across sessions), if its meta still exists;
---  2. otherwise the most recently modified note on disk (by mtime);
---  3. otherwise the default `Snacks.scratch()` (empty notes dir / last resort).
function M.toggle()
    local note = get_last()
    if not (note and vim.uv.fs_stat(note.file .. ".meta")) then
        -- Snacks.scratch.list() is sorted by mtime desc; [1] is the newest note.
        note = Snacks.scratch.list()[1]
    end
    if note then
        Snacks.scratch.open({ file = note.file, name = note.name, ft = note.ft })
    else
        Snacks.scratch()
    end
end

--- Prompt for a name and open a human-readable scratch note at
--- `<notes dir>/<slug>.<ext>`, writing a matching `.meta` so it shows up in
--- `Snacks.scratch.select()` / `list()`.
---@param opts? { ft?: string }
function M.named(opts)
    opts = opts or {}
    local ft = opts.ft or "markdown"
    local ext = ft == "markdown" and "md" or ft
    vim.ui.input({ prompt = "Note name: " }, function(name)
        if not name or vim.trim(name) == "" then
            return
        end
        name = vim.trim(name)
        local dir = git.notes_dir()
        vim.fn.mkdir(dir, "p")
        local note = { file = vim.fs.normalize(("%s/%s.%s"):format(dir, slug(name), ext)), name = name, ft = ft }
        -- Write the sidecar meta if missing so select/list can find it.
        if vim.uv.fs_stat(note.file .. ".meta") == nil then
            vim.fn.writefile(vim.split(vim.json.encode(note), "\n"), note.file .. ".meta")
        end
        M.remember(note)
        Snacks.scratch.open({ file = note.file, name = note.name, ft = note.ft })
    end)
end

return M
