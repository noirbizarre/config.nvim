local panes = require("lib.ui.panes")

return {
    {
        "folke/edgy.nvim",
        -- enabled = false,
        event = "VeryLazy",
        init = function()
            vim.opt.laststatus = 3
            vim.opt.splitkeep = "screen"
        end,
        keys = {
            {
                "<leader>we",
                function() require("edgy").toggle() end,
                desc = "Edgy Toggle",
            },
            -- stylua: ignore
            { "<leader>wE", function() require("edgy").select() end, desc = "Edgy Select Window" },
        },
        opts = {
            animate = { enabled = false },
            -- options = {
            --     left = { size = 30 },
            --     bottom = { size = 10 },
            --     right = { size = 30 },
            --     top = { size = 10 },
            -- },
            icons = {
                closed = " ",
                open = " ",
            },
            keys = {
                -- increase width
                ["<c-Right>"] = function(win) win:resize("width", 2) end,
                -- decrease width
                ["<c-Left>"] = function(win) win:resize("width", -2) end,
                -- increase height
                ["<c-Up>"] = function(win) win:resize("height", 2) end,
                -- decrease height
                ["<c-Down>"] = function(win) win:resize("height", -2) end,
            },
            bottom = panes.bottom,
            left = panes.left,
            right = panes.right,
            wo = {
                winhighlight = "WinBar:EdgyWinBar,,WinBarNC:EdgyWinBar",
            },
        },
    },
    --- Left tree pane
    ---
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        keys = {
            { "<C-b>", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
        },
        cmd = "Neotree",
        opts = function()
            local function on_move(data) Snacks.rename.on_rename_file(data.source, data.destination) end
            local events = require("neo-tree.events")
            return {
                close_if_last_window = true,
                use_libuv_file_watcher = true,
                enable_git_status = true,
                enable_diagnostics = true,
                event_handlers = {
                    { event = events.FILE_MOVED, handler = on_move },
                    { event = events.FILE_RENAMED, handler = on_move },
                },
                sort_case_insensitive = true,
                open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline", "edgy" },
                filesystem = {
                    filtered_items = {
                        hide_dotfiles = false,
                        hide_gitignored = false,
                    },
                    follow_current_file = {
                        enabled = true, -- This will find and focus the file in the active buffer every time
                        --               -- the current file is changed while the tree is open.
                        -- leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
                    },
                    use_libuv_file_watcher = true,
                },
                default_component_configs = {
                    symlink_target = { enabled = true },
                },
                window = {
                    width = 0.2,
                },
            }
        end,
    },
    --- Symbols outline
    --- https://github.com/hedyhli/outline.nvim
    {
        "hedyhli/outline.nvim",
        lazy = true,
        cmd = { "Outline", "OutlineOpen" },
        keys = { -- Example mapping to toggle outline
            { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
        },
        opts = {
            preview_window = {
                auto_preview = true,
            },
        },
    },
    --- Dianostic
    ---
    {
        "folke/trouble.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>xs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>xl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
        opts = {
            modes = {
                lsp = {
                    win = { position = "right" },
                },
            },
        },
    },
}
