return {
    "nvim-telescope/telescope.nvim",
    branch = '0.1.x', -- or tag = '0.1.0',
    cmd = "Telescope",
    keys = { -- { "<leader>ft", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
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
    },
    config = function()
        local telescope = require('telescope')
        local telescopeConfig = require("telescope.config")

        -- Clone the default Telescope configuration
        local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

        -- I want to search in hidden/dot files.
        table.insert(vimgrep_arguments, "--hidden")
        -- I don't want to search in the `.git` directory.
        table.insert(vimgrep_arguments, "--glob")
        table.insert(vimgrep_arguments, "!**/.git/*")

        telescope.setup {
            defaults = {
                -- `hidden = true` is not supported in text grep commands.
                vimgrep_arguments = vimgrep_arguments,
                prompt_prefix = " ",
                selection_caret = " ",
                path_display = { "smart" },
                theme = "dropdown",
            },
            pickers = {
                find_files = {
                    -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
                    find_command = { "rg", "--files", "--follow", "--hidden", "--glob", "!**/.git/*" },
                    theme = "dropdown",
                },
            },
        }
        telescope.load_extension("yaml_schema")
    end
}
