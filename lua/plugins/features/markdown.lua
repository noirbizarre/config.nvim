return {
    {
        "3rd/image.nvim",
        opts = {},
        dependencies = {
            "vhyrro/luarocks.nvim",
            priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
            config = true,
            opts = {
                rocks = { "magick" },
            },
        },
    },
    -- https://github.com/OXY2DEV/markview.nvim
    {
        "OXY2DEV/markview.nvim",
        lazy = false, -- Recommended
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        ft = { "markdown", "Avante", "codecompanion" },
        opts = {
            buf_ignore = {},
            filetypes = { "markdown", "Avante", "codecompanion" },
            modes = { "n", "i", "no", "c" },
            hybrid_modes = { "i" },

            callbacks = {
                on_enable = function(_, win)
                    vim.wo[win].conceallevel = 2
                    vim.wo[win].concealcursor = "nc"
                end,
            },
        },
    },
}
