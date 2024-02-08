return {
    --- The Refactoring library based off the Refactoring book by Martin Fowler
    --- https://github.com/ThePrimeagen/refactoring.nvim
    {
        "ThePrimeagen/refactoring.nvim",
        keys = {{
            "<leader>r",
            function()
                require("refactoring").select_refactor()
            end,
            mode = "v",
            noremap = true,
            silent = true,
            expr = false
        }},
        opts = {}
    },
    -- 
    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        },
        lazy = false,
    },
    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-move.md
    {
        'echasnovski/mini.move',
        version = false,
    },
}
