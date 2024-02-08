return {

    ---
    -- Widgets and helpers
    ---
    -- -- Useful lua function collection
	-- "nvim-lua/plenary.nvim",
    -- -- Some reuusable UI widgets
    -- "MunifTanjim/nui.nvim",
	-- -- Devicons
	-- "nvim-tree/nvim-web-devicons",

	-- Measure startuptime
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		config = function()
			vim.g.startuptime_tries = 10
		end,
	},

    -- colorizer
    {
        "NvChad/nvim-colorizer.lua",
        event = "BufReadPre",
        config = {
            filetypes = { "*", "!lazy" },
            buftype = { "*", "!prompt", "!nofile" },
            user_default_options = {
                RGB = true, -- #RGB hex codes
                RRGGBB = true, -- #RRGGBB hex codes
                names = false, -- "Name" codes like Blue
                RRGGBBAA = true, -- #RRGGBBAA hex codes
                AARRGGBB = false, -- 0xAARRGGBB hex codes
                rgb_fn = true, -- CSS rgb() and rgba() functions
                hsl_fn = true, -- CSS hsl() and hsla() functions
                css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
                -- Available modes: foreground, background,  virtualtext
                mode = "background", -- Set the display mode.
                virtualtext = "■",
                tailwind = true, -- Enable tailwind colors
            },
        },
    },
}
