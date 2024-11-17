return {
    --- The Refactoring library based off the Refactoring book by Martin Fowler
    --- https://github.com/ThePrimeagen/refactoring.nvim
    {
        "ThePrimeagen/refactoring.nvim",
        keys = {
            {
                "<leader>rr",
                function()
                    require("refactoring").select_refactor()
                end,
                mode = "v",
                noremap = true,
                silent = true,
                expr = false
            },
            { "<leader>kr", function() require("telescope").extensions.refactoring.refactors() end, mode = { "v" }, desc = "Refactor", },
        },
        opts = {}
    },
    --- Comments 
    --- https://github.com/numToStr/Comment.nvim
    {
        'numToStr/Comment.nvim',
        lazy = false,
        config = function()
            local comment = require('Comment')
            local ft = require('Comment.ft')

            -- Until https://github.com/numToStr/Comment.nvim/pull/430 is merged
            ft.kdl = {'//%s', '/*%s*/'}

            comment.setup()
        end
    },
    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-move.md
    {
        'echasnovski/mini.move',
        version = false,
        config = true,
    },
    -- Format
    -- https://github.com/stevearc/conform.nvim
    {
        'stevearc/conform.nvim',
        event = "BufWritePre",
    	cmd = { "ConformInfo" },
        keys = {
            {
                "<leader>rf",
                function()
                    require("conform").format({ async = true })
                end,
                desc = "Format buffer",
            },
        },
        opts = {
            formatters_by_ft = {
				lua = { "stylua" },
                python = {'ruff_organize_imports', 'ruff_format'},
                sh = { "shfmt" },
                ["*"] = { "codespell" },
            },
            notify_on_error = true,
        },
    },
    --- Global search and replace
    --- https://github.com/MagicDuck/grug-far.nvim 
    {
        'MagicDuck/grug-far.nvim',
        keys = {
            {'<leader>ss', '<cmd>:lua require("grug-far").open({ transient = true })<CR>', desc = 'Search & replace'},
            {'<leader>S', '<cmd>:lua require("grug-far").toggle_instance({ instanceName="far", staticTitle="Find and Replace" })<CR>', desc = 'Toggle Grug-Far'},
            {'<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', desc = 'Search current word'},
            {'<leader>sw', '<cmd>lua require("spectre").open_visual()<CR>', mode = "v", desc = 'Search current word'},
            {'<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', desc = 'Search on current file'},
        },
        config = function()
            require('grug-far').setup({
                -- ... options, see Configuration section below ...
                -- ... there are no required options atm...
                -- ... engine = 'ripgrep' is default, but 'astgrep' can be specified...
            });
        end
    },
    --- Multicursor support
    --- https://github.com/jake-stewart/multicursor.nvim
    {
        "jake-stewart/multicursor.nvim",
        branch = "1.0",
    }
}
