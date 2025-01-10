return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "someone-stole-my-name/yaml-companion.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "nvim-telescope/telescope-frecency.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim",
            "LinArcX/telescope-env.nvim",
            "benfowler/telescope-luasnip.nvim",
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
            {
                "<leader>kg",
                function() require("telescope").extensions.live_grep_args.live_grep_args() end,
                desc = "Live Grep",
            },
            { "<leader>ky", "<cmd>Telescope yaml_schema<cr>", desc = "YAML Schema" },
            { "<leader>ks", "<cmd>Telescope luasnip<cr>", desc = "Snippets" },

            -- LSP
            { "<leader>li", "<cmd>Telescope lsp_incoming_calls<cr>", desc = "Incoming calls" },
            { "<leader>lo", "<cmd>Telescope lsp_outgoing_calls<cr>", desc = "Outgoing calls" },
            { "<leader>lf", "<cmd>Telescope lsp_references<cr>", desc = "References" },
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

            -- Git
            { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "List all commits" },
            { "<leader>gf", "<cmd>Telescope git_bcommits<cr>", desc = "Current buffer history" },
            { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git branches" },
            { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git status" },
        },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")
            local action_layout = require("telescope.actions.layout")
            local lga_actions = require("telescope-live-grep-args.actions")

            telescope.setup({
                defaults = {
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
                        ".*_cache",
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
                extensions = {
                    ecolog = {
                        shelter = {
                            -- Whether to show masked values when copying to clipboard
                            mask_on_copy = false,
                        },
                        -- Default keybindings
                        mappings = {
                            -- Key to copy value to clipboard
                            copy_value = "<C-y>",
                            -- Key to copy name to clipboard
                            copy_name = "<C-n>",
                            -- Key to append value to buffer
                            append_value = "<C-a>",
                            -- Key to append name to buffer (defaults to <CR>)
                            append_name = "<CR>",
                        },
                    },
                    live_grep_args = {
                        auto_quoting = true, -- enable/disable auto-quoting
                        mappings = { -- extend mappings
                            i = {
                                ["<C-k>"] = lga_actions.quote_prompt(),
                                ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                                -- freeze the current list and start a fuzzy search in the frozen list
                                ["<C-space>"] = actions.to_fuzzy_refine,
                            },
                        },
                    },
                },
            })
            telescope.load_extension("ecolog")
            telescope.load_extension("env")
            telescope.load_extension("frecency")
            telescope.load_extension("fzf")
            telescope.load_extension("live_grep_args")
            telescope.load_extension("luasnip")
            telescope.load_extension("yaml_schema")
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
    --- Quickfix improvements
    --- https://github.com/stevearc/quicker.nvim
    {
        "stevearc/quicker.nvim",
        event = "FileType qf",
        keys = {
            { "<leader>qq", function() require("quicker").toggle() end, desc = "Toggle quickfix" },
        },
        ---@module "quicker"
        ---@type quicker.SetupOptions
        opts = {},
    },
    {
        "https://git.sr.ht/~swaits/zellij-nav.nvim",
        -- lazy = true,
        event = "VeryLazy",
        keys = {
            { "<M-h>", "<cmd>ZellijNavigateLeftTab<cr>", { silent = true, desc = "Navigate left or tab" } },
            { "<M-j>", "<cmd>ZellijNavigateDown<cr>", { silent = true, desc = "Navigate down" } },
            { "<M-k>", "<cmd>ZellijNavigateUp<cr>", { silent = true, desc = "Navigate up" } },
            { "<M-l>", "<cmd>ZellijNavigateRightTab<cr>", { silent = true, desc = "Navigate right or tab" } },
        },
        opts = {},
    },
}
