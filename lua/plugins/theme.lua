return {
    --- Solarized Osaka
    --- https://github.com/craftzdog/solarized-osaka.nvim
    {
        "craftzdog/solarized-osaka.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require('solarized-osaka').setup({
                options = {
                    transparent = false,    -- Disable setting background
			        dim_inactive = true, -- Non focused panes set to alternative background
                }
            })
            -- n.Group.new('TODO', n.colors.blue)

            vim.cmd "colorscheme solarized-osaka"
        end,
    },

}
-- return {
--     --- Helpers, loaded on demand
--     "tjdevries/colorbuddy.nvim",
-- 
--     --- neosolarized
--     --- https://github.com/svrana/neosolarized.nvim
--     -- {
--     --     "svrana/neosolarized.nvim",
--     --     lazy = false,
--     --     priority = 1000,
--     --     dependencies = {
--     --         "tjdevries/colorbuddy.nvim",
--     --     },
-- 
--     --     config = function()
--     --         local neosolarized = require('neosolarized').setup({
--     --             -- comment_italics = true,
--     --             -- background_set = false,
--     --         })
--     --         -- n.Group.new('TODO', n.colors.blue)
-- 
--     --         vim.cmd "colorscheme neosolarized"
--     --     end,
--     -- },
-- 
--     --- Cobalt2
--     --- https://github.com/lalitmee/cobalt2.nvim
--     -- {
--     --     "lalitmee/cobalt2.nvim",
--     --     lazy = false,
--     --     priority = 1000,
--     --     dependencies = {
--     --         "tjdevries/colorbuddy.nvim",
--     --     },
-- 
--     --     config = function()
--     --         require('colorbuddy').colorscheme("cobalt2")
-- 
--     --         -- vim.cmd "colorscheme cobalt2"
--     --     end,
--     -- },
-- 
--     --- solarized
--     -- {
--     --     'ishan9299/nvim-solarized-lua',
--     --     lazy = false,
--     --     priority = 1000,
--     --     config = function()
--     --         vim.cmd "colorscheme solarized"
--     --     end,
--     -- },
-- 
--     --- Nightfox
--     --- https://github.com/EdenEast/nightfox.nvim
--     {
--         "EdenEast/nightfox.nvim",
--         lazy = false,
--         priority = 1000,
--         config = function()
--             require('nightfox').setup({
--                 options = {
--                     transparent = false,    -- Disable setting background
-- 			        dim_inactive = true, -- Non focused panes set to alternative background
--                 }
--             })
--             -- n.Group.new('TODO', n.colors.blue)
-- 
--             vim.cmd "colorscheme nightfox"
--         end,
--     },
-- 
-- }
