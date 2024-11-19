local ascii = require("lib.ui.ascii")

return {
    --- Solarized Osaka
    --- https://github.com/craftzdog/solarized-osaka.nvim
    {
        "craftzdog/solarized-osaka.nvim",
        lazy = false,
        priority = 1000,
        -- opts = {
        --     transparent = false,    -- Disable setting background
        --     dim_inactive = true, -- Non focused panes set to alternative background
        -- },
        config = function()
            require('solarized-osaka').setup({
                transparent = true,    -- Disable setting background
                dim_inactive = true, -- Non focused panes set to alternative background
            })

            vim.cmd "colorscheme solarized-osaka"
        end,
    },
    --- A collection of small QoL plugins for Neovim 
    --- https://github.com/folke/snacks.nvim
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        keys = {
            { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
            { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
            { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
            { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
            { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse" },
            -- { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
            { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
            { "<leader>cR", function() Snacks.rename() end, desc = "Rename File" },
            -- { "<c-/>",      function() Snacks.terminal() end, desc = "Toggle Terminal" },
            -- { "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore" },
            { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
            { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
        },
        opts = {
            bigfile = { enabled = true },
            dashboard = {
                enabled = true,
                preset = {
                    header = ascii.neovim,
                    keys = {
                        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                        { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                        { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                        { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                        -- { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                        { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                        { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy },
                        { icon = " ", key = "m", desc = "Mason", action = ":Mason" },
                        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                    }
                },
                sections = {
                    { section = "header" },
                    {
                      pane = 2,
                      section = "terminal",
                      cmd = "colorscript -e square",
                      height = 5,
                      padding = 1,
                    },
                    { section = "keys", gap = 1, padding = 1 },
                    { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                    { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
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
            quickfile = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
            styles = {
                notification = {
                    wo = { wrap = true } -- Wrap notifications
                }
            }
        },
    },
    --- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu
    --- https://github.com/folke/noice.nvim
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("noice").setup({
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
            })
        end,
    },
    --- Top bufferline/tabline
    --- https://github.com/akinsho/bufferline.nvim
    {
        "akinsho/bufferline.nvim",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        keys = {
            {"<S-Left>", "<cmd>BufferLineCyclePrev<cr>", desc="Next buffer"},
            {"<S-Right>", "<cmd>BufferLineCycleNext<cr>", desc="Previous buffer"},
            {"<C-S-Left>", "<cmd>BufferLineMovePrev<cr>", desc="Move to next buffer"},
            {"<C-S-Right>", "<cmd>BufferLineMoveNext<cr>", desc="Move to previous buffer"},
        },
        opts = {
            options = {
                diagnostics = "nvim_lsp",
                always_show_bufferline = false,
                offsets = {
                    { filetype = "NvimTree", text = "", padding = 1 },
                    { filetype = "neo-tree", text = "", padding = 1 },
                    { filetype = "Outline", text = "", padding = 1 },
                },
            }
        },
    },
    --- Bottom status bar
    --- https://github.com/nvim-lualine/lualine.nvim
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "someone-stole-my-name/yaml-companion.nvim",
        },
        event = "VeryLazy",
        opts = require("lib.ui.lualine"),
    },
    --- Set and display key bindings
    --- https://github.com/folke/which-key.nvim
    {
        "folke/which-key.nvim",
        cmd = "WhichKey",
        event = "VeryLazy",
        keys = {
            { "<leader>,", "<cmd>WhichKey<cr>", desc = "Keymaps (which-key)" },
            { "<leader>/", "<cmd>WhichKey<cr>", desc = "Keymaps (which-key)" },
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
        opts= {
            spec = require("lib.keymaps"),
        },
    },
}
