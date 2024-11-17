return {
    "nvim-telescope/telescope.nvim",
    branch = '0.1.x', -- or tag = '0.1.0',
    cmd = "Telescope",
    keys = {
        { "<C-k>", "<cmd>Telescope find_files<cr>", desc = "Telescope" },
        { "<leader>kb", "<cmd>Telescope buffers<cr>", desc = "Telescope buffers" },
        { "<leader>kg", "<cmd>Telescope live_grep<cr>", desc = "Telescope Live Grep" },
        { "<leader>ks", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Telescope Workspace Symbols" },
        { "<leader>ky", "<cmd>Telescope yaml_schema<cr>", desc = "Telescope YAML Schema" },
    },
    dependencies = {
        'nvim-lua/plenary.nvim',
        "nvim-treesitter/nvim-treesitter",
        "someone-stole-my-name/yaml-companion.nvim",
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
        local telescope = require('telescope')
        local telescopeConfig = require("telescope.config")

        local dropdown = require("telescope.themes").get_dropdown({
            width = 0.8,
        })

        -- Clone the default Telescope configuration
        local vimgrep_args = { unpack(telescopeConfig.values.vimgrep_arguments) }

        -- I want to search in hidden/dot files.
        table.insert(vimgrep_args, "--hidden")
        table.insert(vimgrep_args, '--follow')
        table.insert(vimgrep_args, '--no-ignore-vcs')
        table.insert(vimgrep_args, '--glob')
        table.insert(vimgrep_args, '!**/.git/*')
        table.insert(vimgrep_args, '--glob')
        table.insert(vimgrep_args, '!**/.venv/*')
        table.insert(vimgrep_args, '--glob')
        table.insert(vimgrep_args, '!**/node_modules/*')

        -- Don't exclude git ignored files
        -- table.insert(vimgrep_arguments, "--unrestricted")

        telescope.setup {
            defaults = {
                -- `hidden = true` is not supported in text grep commands.
                vimgrep_arguments = vimgrep_args,
                prompt_prefix = " ",
                selection_caret = " ",
                path_display = { "smart" },
                theme = "dropdown",
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
                layout_config = {
                    width = 0.8,
                    -- vertical = {
                    --     width = 0.8,
                    -- },
                   center = {
                        width = 0.8,
                    },
                }
            },
            pickers = {
                find_files = {
                    hidden = true,
                    find_command = {
                        'rg',
                        '--files',
                        '--color', 'never',
                        "--hidden",
                        "--no-ignore-vcs",
                        "--follow",
                        '-g', '!{.venv,node_modules,.git,.*_cache,dist,.tox,__pycache__,**.pyc,**.min.js}',
                    },
                    -- theme = dropdown,
                    theme = "dropdown",
                },
            },
        }
        telescope.load_extension('fzf')
        telescope.load_extension("yaml_schema")
        telescope.load_extension("refactoring")
    end
}
