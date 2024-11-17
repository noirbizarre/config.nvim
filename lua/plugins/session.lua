-- ahmedkhalf/project.nvim
return {
	-- Measure startuptime
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		config = function()
			vim.g.startuptime_tries = 10
		end,
	},
    --- Load global and project settings from JSON 
    --- https://github.com/folke/neoconf.nvim
    {
        "folke/neoconf.nvim",
        cmd = {
            "NeoConf"
        },
        config = function()
            require("neoconf").setup({
                -- override any of the default settings here
            })
        end,
    },

    --- Session persistence
    --- https://github.com/folke/persistence.nvim
    {
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        opts = {
        -- add any custom options here
        }
    },

    --- Privileges escalation
    {
		"lambdalisue/suda.vim",
		lazy = false,
        init = function()
            vim.g["suda_smart_edit"] = 1
        end
	},

    --- Projections project manager 
    --- https://github.com/gnikdroy/projections.nvim
    -- {
    --     "gnikdroy/projections.nvim",
    --     -- cmd = {
    --     --     "Telescope projects",
    --     -- },
    --     -- lazy = false,
    --     keys = {
    --         {"<leader>fp", "<cmd>Telescope projections<cr>", desc = "Projects"},
    --     },
    --     -- event = "BufReadPre",
    --     dependencies = {
    --         "nvim-telescope/telescope.nvim",
    --     },
    --     config = function()
    --         require("projections").setup({
    --             workspaces = {
    --                 "~/Workspaces",
    --                 "~/Workspaces/_contribs",
    --                 "~/Workspaces/sites",
    --                 "~/Workspaces/pdm-plugins",
    --                 "~/Workspaces/pelican-plugins",
    --                 "~/Workspaces/copier.templates",
    --                 "~/.config",
    --             },
    --             patterns = {
    --                 ".git",
    --                 "_darcs",
    --                 ".hg",
    --                 ".bzr",
    --                 ".svn",
    --                 "Makefile",
    --                 ".neoconf.json",
    --                 -- "package.json",
    --                 "pyproject.toml",
    --                 "Cargo.toml",
    --             },
    --             workspaces_file = vim.fn.stdpath("data") .. 'projections.json'
    --         })
    --
    --         -- Bind <leader>fp to Telescope projections
    --         require('telescope').load_extension('projections')
    --
    --         -- Autostore session on VimExit
    --         local Session = require("projections.session")
    --         vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
    --             callback = function() Session.store(vim.loop.cwd()) end,
    --         })
    --
    --         -- Switch to project if vim was started in a project dir
    --         local switcher = require("projections.switcher")
    --         vim.api.nvim_create_autocmd({ "VimEnter" }, {
    --             callback = function()
    --                 if vim.fn.argc() == 0 then switcher.switch(vim.loop.cwd()) end
    --             end,
    --         })
    --     end
    -- },
}
