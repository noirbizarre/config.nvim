return {
    --- The Refactoring library based off the Refactoring book by Martin Fowler
    --- https://github.com/ThePrimeagen/refactoring.nvim
    {
        "ThePrimeagen/refactoring.nvim",
        keys = {
            {
                "<leader>r",
                function()
                    require("refactoring").select_refactor()
                end,
                mode = "v",
                noremap = true,
                silent = true,
                expr = false
            },
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
    },
    -- Global search and replace
    -- https://github.com/nvim-pack/nvim-spectre
    {
        'nvim-pack/nvim-spectre',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        keys = {
            {'<leader>S', '<cmd>lua require("spectre").toggle()<CR>', desc = 'Toggle Spectre'},
            {'<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', desc = 'Search current word'},
            {'<leader>sw', '<cmd>lua require("spectre").open_visual()<CR>', mode = "v", desc = 'Search current word'},
            {'<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', desc = 'Search on current file'},
        },
    },
}
