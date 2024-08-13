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

}
