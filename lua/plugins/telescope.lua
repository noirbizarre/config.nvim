return {
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
        { "<leader>kb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
        { "<leader>ke", "<cmd>Telescope env<cr>", desc = "Environment variables" },
        { "<leader>kk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
        { "<leader>k;", function()
            require("telescope.builtin").symbols{
                sources = {'emoji', 'gitmoji', "nerd", "math"},
                layout_strategy="vertical",
                layout_config={width=0.3, height=0.5},
            }
        end, desc = "Emojis" },
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
            function()
                vim.lsp.buf.code_action()
            end,
            desc = "Code Action",
        },
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
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
                    i = {
                        ["<esc>"] = actions.close,
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
}
