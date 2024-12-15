return {
    --- Snippets
    --- https://github.com/L3MON4D3/LuaSnip
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
        -- stylua: ignore
        keys = {
            {
                "<tab>",
                function()
                    return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
                end,
                expr = true,
                silent = true,
                mode = "i"
            },
            {
                "<tab>",
                function()
                    require("luasnip").jump(1)
                end,
                mode = "s"
            },
            {
                "<s-tab>",
                function()
                    require("luasnip").jump(-1)
                end,
                mode = {"i", "s"}
            },
        },
        config = function() require("luasnip.loaders.from_vscode").lazy_load() end,
    },
    --- Blink nvim-cmp compatibility layer
    --- https://github.com/saghen/blink.compat
    {
        "saghen/blink.compat",
        opts = {},
    },
    --- Blink completion engine
    --- https://github.com/Saghen/blink.cmp
    {
        "saghen/blink.cmp",
        lazy = false, -- lazy loading handled internally
        dependencies = {
            "rafamadriz/friendly-snippets",
            "hrsh7th/cmp-emoji",
        },
        version = "v0.*",

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' for mappings similar to built-in completion
            -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
            -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
            -- see the "default configuration" section below for full documentation on how to define
            -- your own keymap.
            keymap = { preset = "super-tab" },

            appearance = {
                -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                -- Useful for when your theme doesn't support blink.cmp
                -- will be removed in a future release
                use_nvim_cmp_as_default = true,
                -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = "normal",
            },

            -- default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, via `opts_extend`
            sources = {
                -- default = { "lsp", "path", "snippets", "buffer", "emoji" },
                -- optionally disable cmdline completions
                -- cmdline = {},
                completion = {
                    -- remember to enable your providers here
                    enabled_providers = { "lsp", "path", "snippets", "ecolog", "buffer", "emoji", },
                },
                providers = {
                    emoji = { name = "emoji", module = "blink.compat.source" },
                    ecolog = { name = "ecolog", module = "ecolog.integrations.cmp.blink_cmp" },
                },
            },

            -- experimental signature help support
            -- signature = { enabled = true }
        },
        -- allows extending the providers array elsewhere in your config
        -- without having to redefine it
        opts_extend = { "sources.default" },
    },
    {
        "philosofonusus/ecolog.nvim",
        -- dependencies = {
        --     "hrsh7th/nvim-cmp", -- Optional: for autocompletion support (recommended)
        -- },
        -- Optional: you can add some keybindings
        -- (I personally use lspsaga so check out lspsaga integration or lsp integration for a smoother experience without separate keybindings)
        keys = {
            { "<leader>eg", "<cmd>EcologGoto<cr>", desc = "Go to env file" },
            { "<leader>ep", "<cmd>EcologPeek<cr>", desc = "Ecolog peek variable" },
            { "<leader>es", "<cmd>EcologSelect<cr>", desc = "Switch env file" },
            { "<leader>et", "<cmd>Telescope ecolog env<cr>", desc = "Telescope environment variable picker" },
        },
        -- Lazy loading is done internally
        lazy = false,
        opts = {
            integrations = {
                blink_cmp = true,
            },
            -- Enables shelter mode for sensitive values
            shelter = {
                configuration = {
                    partial_mode = false, -- false by default, disables partial mode, for more control check out shelter partial mode
                    mask_char = "*", -- Character used for masking
                },
                modules = {
                    cmp = true, -- Mask values in completion
                    peek = false, -- Mask values in peek view
                    files = false, -- Mask values in files
                    telescope = false, -- Mask values in telescope
                },
            },
            -- true by default, enables built-in types (database_url, url, etc.)
            types = true,
            path = vim.fn.getcwd(), -- Path to search for .env files
            preferred_environment = "development", -- Optional: prioritize specific env files
        },
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {}, -- this is equalent to setup({}) function
    },
}
