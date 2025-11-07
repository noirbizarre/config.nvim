local ascii = require("lib.ui.ascii")
local ft = require("lib.filetypes")

local gitwin = { win = { width = 0.4, height = 0.4 } }

return {
    --- Solarized Osaka
    {
        "craftzdog/solarized-osaka.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("solarized-osaka").setup({
                transparent = true, -- Disable setting background
                terminal_colors = false,
                dim_inactive = true, -- Non focused panes set to alternative background
                styles = {
                    sidebars = "transparent",
                    -- floats = "transparent",
                },
                sidebars = { "qf", "help", "sidekick_terminal", "snacks_terminal", "terminal" },
                ---@param hl Highlights
                ---@param c ColorScheme
                on_highlights = function(hl, c)
                    --- Transparent Telescope
                    hl.TelescopeNormal = {
                        bg = c.bg_dark,
                        fg = c.fg_dark,
                    }
                    hl.TelescopeBorder = {
                        bg = c.bg_dark,
                        fg = c.base02,
                    }
                    hl.TelescopePreviewTitle = {
                        bg = c.bg_dark,
                        fg = c.bg_dark,
                    }
                    hl.TelescopeResultsTitle = {
                        bg = c.bg_dark,
                        fg = c.bg_dark,
                    }
                    --- Reusable rainbow values
                    hl.RainbowRed = { fg = c.red }
                    hl.RainbowOrange = { fg = c.orange }
                    hl.RainbowYellow = { fg = c.yellow }
                    hl.RainbowGreen = { fg = c.green }
                    hl.RainbowBlue = { fg = c.blue }
                    hl.RainbowViolet = { fg = c.violet }
                    hl.RainbowCyan = { fg = c.cyan }

                    --- Snacks
                    hl.SnacksPicker = {
                        bg = c.bg_dark,
                        fg = c.blue300,
                    }
                    hl.SnacksPickerPrompt = {
                        fg = c.magenta300,
                    }
                    hl.SnacksPickerTitle = {
                        bg = c.bg_dark,
                        fg = c.cyan300,
                        -- fg = c.magenta300,
                    }
                    hl.SnacksPickerPreviewTitle = {
                        link = "SnacksPickerTitle",
                    }
                    hl.SnacksPickerBorder = {
                        bg = c.bg_dark,
                        fg = c.blue300,
                    }
                    hl.SnacksGhBorder = {
                        link = "SnacksPickerBorder",
                    }
                    hl.SnacksGhNormalFloat = {
                        link = "Normal",
                    }
                    hl.SnacksGhTitle = {
                        link = "SnacksPickerPreviewTitle",
                    }

                    -- Tree Sitter Context
                    hl.TreesitterContext = { bg = c.base03 }
                    hl.TreesitterContextBottom = { underline = true }

                    -- Avante
                    hl.AvanteSidebarNormal = { link = "Normal" }
                    hl.AvanteReversedTitle = { bg = c.bg_dark }
                    -- hl.AvanteReversedSubtitle = { fg = c.bg_dark,  bg  = c.bg_dark }
                    -- hl.AvanteReversedThirdTitle = { fg = c.blue300 }
                    hl.AvanteSidebarWinSeparator = { link = "WinSeparator" }
                    hl.AvanteSidebarWinHorizontalSeparator = { link = "WinSeparator" }

                    hl.SidekickChat = { link = "Normal" }
                    hl.EdgyNormal = { link = "Normal" }
                end,
            })

            vim.cmd("colorscheme solarized-osaka")
        end,
    },
    --- A collection of small QoL plugins for Neovim
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        keys = {
            --- Base Pickers
            { "<C-k>", function() Snacks.picker.files() end, desc = "File picker" },
            { "<leader>kf", function() Snacks.picker.files() end, desc = "File picker" },
            { "<leader>kg", function() Snacks.picker.grep() end, desc = "Live grep" },
            {
                "<leader>kw",
                function() Snacks.picker.grep_word() end,
                desc = "Visual selection or word",
                mode = { "n", "x" },
            },
            { "<leader>kb", function() Snacks.picker.buffers() end, desc = "Buffers" },
            { "<leader>km", function() Snacks.picker.marks() end, desc = "Marks" },
            { "<leader>kn", function() Snacks.picker.noice() end, desc = "Noice" },
            { "<leader>kj", function() Snacks.picker.jumps() end, desc = "Jumps" },
            { "<leader>kk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
            { "<leader>kh", function() Snacks.picker.help() end, desc = "Help Pages" },
            { "<leader>kq", function() Snacks.picker.qflist() end, desc = "Quickfixes" },
            { "<leader>kc", function() Snacks.picker.command_history() end, desc = "Command history" },
            { "<leader>ku", function() Snacks.picker.undo() end, desc = "Undo tree" },
            { "<leader>kl", function() Snacks.picker.spelling() end, desc = "Spelling" },
            { "<leader>kv", function() Snacks.picker.registers() end, desc = "Registers" },
            { "<leader>k,", function() Snacks.picker.resume() end, desc = "Resume" },
            {
                "<leader>k;",
                function() Snacks.picker.icons() end,
                desc = "Emojis",
            },
            {
                "<M-;>",
                function() Snacks.picker.icons() end,
                desc = "Emojis",
                mode = { "n", "i" },
            },
            --- LSP
            { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Go to Definition" },
            { "gi", function() Snacks.picker.lsp_implementations() end, desc = "Go to Implementation" },
            { "gt", function() Snacks.picker.lsp_type_definitions() end, desc = "Go to Type Definition" },
            { "<leader>lf", function() Snacks.picker.lsp_references() end, desc = "References" },
            { "<leader>ls", function() Snacks.picker.lsp_symbols() end, desc = "Symbols" },
            { "<leader>lw", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Workspace symbols" },
            { "<leader>lc", function() Snacks.picker.lsp_incoming_calls() end, desc = "Incoming calls" },
            { "<leader>ld", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
            --- Git
            { "<leader>gh", function() Snacks.picker.git_log() end, desc = "History" },
            { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Current buffer history" },
            { "<leader>gl", function() Snacks.picker.git_log_line() end, desc = "Current line history" },
            { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
            { "<leader>gt", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
            { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
            { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff" },
            { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
            { "<leader>gB", function() Snacks.gitbrowse() end, mode = { "n", "v" }, desc = "Git Browse" },
            {
                "<leader>gM",
                function() Snacks.gitbrowse({ what = "file", branch = "main" }) end,
                mode = { "n", "v" },
                desc = "Git Browse (main)",
            },
            { "<leader>gcc", function() Snacks.terminal("git commit", gitwin) end, desc = "Git Commit" },
            { "<leader>gca", function() Snacks.terminal("git amend", gitwin) end, desc = "Git Commit Amend" },
            { "<leader>gcA", function() Snacks.terminal("git commit --all", gitwin) end, desc = "Git Commit All" },
            { "<leader>gcz", function() Snacks.terminal("cz commit", gitwin) end, desc = "Git Commit(izen)" },
            { "<leader>gp", function() Snacks.terminal("git add -p") end, desc = "Git Partial Add" },
            { "<leader>gi", function() Snacks.picker.gh_issue() end, desc = "GitHub Issues" },
            { "<leader>gI", function() Snacks.picker.gh_pr() end, desc = "GitHub Pull Requests" },
            --- Buffers
            { "<leader>bb", function() Snacks.picker.buffers() end, desc = "Buffers" },
            { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
            { "<leader>bs", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
            { "<leader>bS", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
            --- Refactoring
            { "<leader>rR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
            --- UI & Motions
            { "<leader>z", function() Snacks.zen() end, desc = "Toggle Zen Mode" },
            { "<leader>Z", function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
            {
                "<leader>un",
                function() Snacks.notifier.hide() end,
                desc = "Dismiss All Notifications",
            },
            { "<c-/>", function() Snacks.terminal() end, desc = "Toggle Terminal" },
            { "<c-_>", function() Snacks.terminal() end, desc = "which_key_ignore" },
            {
                "]]",
                function() Snacks.words.jump(vim.v.count1) end,
                desc = "Next Reference",
                mode = { "n", "t" },
            },
            {
                "[[",
                function() Snacks.words.jump(-vim.v.count1) end,
                desc = "Prev Reference",
                mode = { "n", "t" },
            },
        },
        opts = {
            bigfile = { enabled = true },
            dashboard = {
                enabled = true,
                preset = {
                    header = ascii.neovim,
                    keys = {
                        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                        {
                            icon = " ",
                            key = "f",
                            desc = "Find File",
                            action = ":lua Snacks.picker.files()",
                        },
                        {
                            icon = " ",
                            key = "g",
                            desc = "Find Text",
                            action = ":lua Snacks.picker.grep()",
                        },
                        {
                            icon = " ",
                            key = "r",
                            desc = "Recent Files",
                            action = ":lua Snacks.picker.recent()",
                        },
                        { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                        { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy },
                        { icon = " ", key = "m", desc = "Mason", action = ":Mason" },
                        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                    },
                },
                sections = {
                    { section = "header" },
                    {
                        pane = 2,
                        section = "terminal",
                        -- cmd = "colorscript -e six",
                        cmd = "colorscript -e square",
                        height = 5,
                        padding = 1,
                    },
                    { section = "keys", gap = 1, padding = 1 },
                    {
                        pane = 2,
                        icon = " ",
                        title = "Recent Files",
                        section = "recent_files",
                        cwd = true,
                        indent = 2,
                        padding = 1,
                        limit = 8,
                    },
                    {
                        pane = 2,
                        icon = " ",
                        title = "Git Status",
                        section = "terminal",
                        enabled = vim.fn.isdirectory(".git") == 1,
                        cmd = "hub status --short --branch --renames",
                        height = 5,
                        padding = 1,
                        ttl = 5 * 60,
                        indent = 3,
                    },
                    { section = "startup" },
                },
            },
            notifier = {
                enabled = true,
                timeout = 3000,
            },
            image = {},
            indent = {
                enabled = true,
                indent = {
                    enabled = true,
                    char = "",
                    hl = {
                        "RainbowRed",
                        "RainbowYellow",
                        "RainbowBlue",
                        "RainbowOrange",
                        "RainbowGreen",
                        "RainbowViolet",
                        "RainbowCyan",
                    },
                },
                scope = {
                    enabled = true,
                    char = "┆",
                },
                chunk = {
                    enabled = true,
                    char = {
                        -- corner_top = "┌",
                        -- corner_bottom = "└",
                        corner_top = "╭",
                        corner_bottom = "╰",
                        horizontal = "┄",
                        vertical = "┆",
                        arrow = "",
                    },
                },
                -- filter for buffers to enable indent guides
                filter = function(buf)
                    return vim.g.snacks_indent ~= false
                        and vim.b[buf].snacks_indent ~= false
                        and vim.bo[buf].buftype == ""
                        and not vim.tbl_contains(ft.internals, vim.bo.filetype)
                end,
            },
            input = { enabled = true },
            picker = {
                prompt = "   ",
                formatters = {
                    file = {
                        truncate = 80,
                    },
                },
                sources = {
                    files = {
                        hidden = true,
                    },
                    grep = {
                        hidden = true,
                    },
                    lsp_symbols = {
                        filter = {
                            default = true,
                        },
                    },
                },
                win = {
                    -- input window
                    input = {
                        keys = {
                            -- ["<Esc>"] = { "close", mode = { "n", "i" } },
                            ["<c-l>"] = { "toggle_live", mode = { "i", "n" } },
                            ["<c-i>"] = { "toggle_ignored", mode = { "i", "n" } },
                            ["<c-r>"] = { "toggle_ignored", mode = { "i", "n" } },
                            ["<c-h>"] = { "toggle_hidden", mode = { "i", "n" } },
                            ["<PageDown>"] = { "list_scroll_down", mode = { "i", "n" } },
                            ["<PageUp>"] = { "list_scroll_up", mode = { "i", "n" } },
                        },
                    },
                    list = {
                        keys = {
                            ["<PageDown>"] = "list_scroll_down",
                            ["<PageUp>"] = "list_scroll_up",
                        },
                    },
                    preview = {
                        keys = {
                            ["<PageDown>"] = "preview_scroll_down",
                            ["<PageUp>"] = "preview_scroll_up",
                        },
                        footer_keys = true,
                    },
                },
            },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
            styles = {
                notification = {
                    wo = { wrap = true }, -- Wrap notifications
                },
            },
            zen = {
                win = {
                    backdrop = {
                        transparent = true,
                        bg = "#003345",
                        -- bg = "#e5e9f0",
                        blend = 60,
                    },
                    wo = { winhighlight = "NormalFloat:Normal" },
                    width = 140,
                },
            },
        },
    },

    --- Menu
    { "nvzone/volt", lazy = true },
    {
        "nvzone/menu",
        lazy = true,
        keys = {
            -- mouse users + nvimtree users!
            { "<RightMouse>", function() require("lib.ui.menus").context_menu() end, mode = { "n", "v" } },
        },
    },

    --- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        cmd = "Noice",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        opts = {
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = true, -- use a classic bottom cmdline for search
                command_palette = true, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false, -- add a border to hover docs and signature help
            },
            routes = {
                {
                    filter = {
                        event = "lsp",
                        kind = "progress",
                        cond = function(message)
                            local client = vim.tbl_get(message.opts, "progress", "client")
                            local ignored = { "ltex", "ltex_plus" }
                            return ignored[client] == nil
                        end,
                    },
                    opts = { skip = true },
                },
            },
        },
    },
    --- Bottom status bar
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            {
                "SmiteshP/nvim-navic",
                opts = {
                    highlight = true,
                    -- click = true,
                    lsp = {
                        auto_attach = true,
                    },
                },
            },
            "AndreM222/copilot-lualine",
        },
        event = "VeryLazy",
        opts = function()
            --- Allows to requires other plugins
            return require("lib.ui.lualine")
        end,
    },
    --- Set and display key bindings
    {
        "folke/which-key.nvim",
        cmd = "WhichKey",
        event = "VeryLazy",
        keys = {
            { "<leader>,", "<cmd>WhichKey<cr>", desc = "Keymaps (which-key)" },
            { "<leader>/", "<cmd>WhichKey<cr>", desc = "Keymaps (which-key)" },
            {
                "<leader>?",
                function() require("which-key").show({ global = false }) end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
        opts = {
            spec = require("lib.keymaps"),
        },
    },
    -- Better inline diagnostic
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = { "VeryLazy", "LspAttach" },
        priority = 1000, -- needs to be loaded in first
        config = function()
            vim.diagnostic.config({ virtual_text = false }) -- Disable the builtin diagnostic
            require("tiny-inline-diagnostic").setup({
                preset = "powerline",
                options = {
                    show_source = true,
                    -- use_icons_from_diagnostic = true,
                },
            })
        end,
    },
}
