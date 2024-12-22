local icons = require("lib.ui.icons")

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
            "giuxtaposition/blink-cmp-copilot",
        },
        version = "v0.*",
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        ---@diagnostic disable: missing-fields
        opts = {
            -- 'default' for mappings similar to built-in completion
            -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
            -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
            keymap = { preset = "super-tab" },
            appearance = {
                kind_icons = icons.kinds,
            },
            sources = {
                default = {
                    "lsp",
                    "path",
                    "snippets",
                    "buffer",
                    "copilot",
                    "ecolog",
                    "emoji",
                    "codecompanion",
                },
                providers = {
                    emoji = { name = "emoji", module = "blink.compat.source" },
                    ecolog = { name = "ecolog", module = "ecolog.integrations.cmp.blink_cmp" },
                    codecompanion = { name = "CodeCompanion", module = "codecompanion.providers.completion.blink" },
                    copilot = {
                        name = "copilot",
                        module = "blink-cmp-copilot",
                        transform_items = function(_, items)
                            local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
                            local kind_idx = #CompletionItemKind + 1
                            CompletionItemKind[kind_idx] = "Copilot"
                            for _, item in ipairs(items) do
                                item.kind = kind_idx
                            end
                            return items
                        end,
                        score_offset = 100,
                        async = true,
                    },
                },
            },
            completion = {
                documentation = {
                    -- Controls whether the documentation window will automatically show when selecting a completion item
                    auto_show = true,
                    auto_show_delay_ms = 500,
                },
            },

            -- experimental signature help support
            signature = { enabled = true },
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
