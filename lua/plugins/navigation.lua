return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "someone-stole-my-name/yaml-companion.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "nvim-telescope/telescope-frecency.nvim",
            "LinArcX/telescope-env.nvim",
        },
        branch = "0.1.x", -- or tag = '0.1.0',
        cmd = "Telescope",
        keys = {
            { "<C-k>", "<cmd>Telescope find_files<cr>", desc = "Telescope" },
            { "<leader>kf", "<cmd>Telescope find_files<cr>", desc = "Find files" },
            { "<leader>km", "<cmd>Telescope marks<cr>", desc = "Find files" },
            {
                "<leader>kb",
                function()
                    require("telescope.builtin").buffers({
                        sort_mru = true,
                        sort_lastused = true,
                        initial_mode = "normal",
                    })
                end,
                desc = "Buffers",
            },
            { "<leader>ke", "<cmd>Telescope env<cr>", desc = "Environment variables" },
            { "<leader>kk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
            {
                "<leader>k;",
                function()
                    require("telescope.builtin").symbols({
                        sources = { "emoji", "gitmoji", "nerd", "math" },
                        layout_strategy = "vertical",
                        layout_config = { width = 0.3, height = 0.5 },
                    })
                end,
                desc = "Emojis",
            },
            { "<leader>kg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
            { "<leader>ky", "<cmd>Telescope yaml_schema<cr>", desc = "YAML Schema" },

            -- LSP
            { "<leader>li", "<cmd>Telescope lsp_incoming_calls<cr>", desc = "Incoming calls" },
            { "<leader>lo", "<cmd>Telescope lsp_outgoing_calls<cr>", desc = "Outgoing calls" },
            { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
            { "<leader>lw", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace Symbols" },
            { "<leader>lgi", "<cmd>Telescope lsp_implementations<cr>", desc = "Go to implementation" },
            { "<leader>lgd", "<cmd>Telescope lsp_definitions<cr>", desc = "Go to definition" },
            { "<leader>lgt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Go to type definition" },
            {
                "<leader>la",
                function() vim.lsp.buf.code_action() end,
                desc = "Code Action",
            },
        },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")
            local action_layout = require("telescope.actions.layout")
            local config = require("telescope.config")

            -- Clone the default Telescope configuration
            local vimgrep_args = { unpack(config.values.vimgrep_arguments) }

            -- I want to search in hidden/dot files.
            table.insert(vimgrep_args, "--hidden")
            table.insert(vimgrep_args, "--follow")
            table.insert(vimgrep_args, "--no-ignore-vcs")
            table.insert(vimgrep_args, "--glob")
            table.insert(vimgrep_args, "!**/.git/*")
            table.insert(vimgrep_args, "--glob")
            table.insert(vimgrep_args, "!**/.venv/*")
            table.insert(vimgrep_args, "--glob")
            table.insert(vimgrep_args, "!**/node_modules/*")

            -- Don't exclude git ignored files
            -- table.insert(vimgrep_arguments, "--unrestricted")

            telescope.setup({
                defaults = {
                    -- `hidden = true` is not supported in text grep commands.
                    vimgrep_arguments = vimgrep_args,
                    prompt_prefix = "  ",
                    selection_caret = " ",
                    selection_strategy = "reset",
                    sorting_strategy = "ascending",
                    layout_strategy = "horizontal",
                    file_ignore_patterns = {
                        "node_modules",
                        ".venv",
                        "venv",
                        ".git/",
                        ".pdm-build",
                        "target",
                        "vendor",
                        "build",
                        "dist",
                        "__pycache__",
                    },
                    mappings = {
                        n = {
                            ["<M-p>"] = action_layout.toggle_preview,
                            ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
                            ["d"] = actions.delete_buffer + actions.move_to_top,
                        },
                        i = {
                            ["<esc>"] = actions.close,
                            ["<C-u>"] = false,
                            ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
                            ["<M-p>"] = action_layout.toggle_preview,
                        },
                    },
                    layout_config = {
                        prompt_position = "top",
                        horizontal = {
                            prompt_position = "top",
                            preview_width = 0.5,
                        },
                    },
                },
                pickers = {
                    find_files = {
                        hidden = true,
                        find_command = {
                            "rg",
                            "--files",
                            "--color",
                            "never",
                            "--hidden",
                            "--no-ignore-vcs",
                            "--follow",
                            "-g",
                            "!{.venv,node_modules,.git,.*_cache,dist,.tox,__pycache__,**.pyc,**.min.js}",
                        },
                    },
                },
            })
            telescope.load_extension("fzf")
            telescope.load_extension("yaml_schema")
            telescope.load_extension("env")
            telescope.load_extension("frecency")
        end,
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "letieu/harpoon-lualine",
        },
        keys = {
            {
                "<leader>hh",
                function()
                    local harpoon = require("harpoon")
                    harpoon.ui:toggle_quick_menu(harpoon:list())
                end,
                desc = "Toggle menu",
            },
            { "<leader>ha", function() require("harpoon"):list():add() end, desc = "Add file" },
            { "<leader>hd", function() require("harpoon"):list():remove() end, desc = "Remove file" },
            { "<leader>hk", function() require("harpoon"):list():next() end, desc = "Next file" },
            {
                "<leader>hj",
                function() require("harpoon"):list():prev() end,
                desc = "Previous file",
            },
            {
                "<leader>h1",
                function() require("harpoon"):list():select(1) end,
                desc = "Go to file 1",
            },
            {
                "<leader>h2",
                function() require("harpoon"):list():select(2) end,
                desc = "Go to file 2",
            },
            {
                "<leader>h3",
                function() require("harpoon"):list():select(3) end,
                desc = "Go to file 3",
            },
            {
                "<leader>h4",
                function() require("harpoon"):list():select(4) end,
                desc = "Go to file 4",
            },
            {
                "<leader>h5",
                function() require("harpoon"):list():select(5) end,
                desc = "Go to file 5",
            },
            --- AZERTY compat' until new laptop
            {
                "<leader>h&",
                function() require("harpoon"):list():select(1) end,
                desc = "Go to file 1",
            },
            {
                "<leader>hé",
                function() require("harpoon"):list():select(2) end,
                desc = "Go to file 2",
            },
            {
                '<leader>h"',
                function() require("harpoon"):list():select(3) end,
                desc = "Go to file 3",
            },
            {
                "<leader>h'",
                function() require("harpoon"):list():select(4) end,
                desc = "Go to file 4",
            },
            {
                "<leader>h(",
                function() require("harpoon"):list():select(5) end,
                desc = "Go to file 5",
            },
        },
        opts = {
            settings = {
                save_on_toggle = true,
                sync_on_ui_close = true,
            },
        },
    },
}
