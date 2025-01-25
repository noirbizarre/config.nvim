local icons = require("lib.ui.icons")

return {
    --- Snippets
    --- https://github.com/L3MON4D3/LuaSnip
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            {
                "rafamadriz/friendly-snippets",
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                    require("luasnip.loaders.from_vscode").lazy_load({
                        paths = { vim.fn.stdpath("config") .. "/snippets" },
                    })
                end,
            },
        },
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
    },
    --- Blink completion engine
    --- https://github.com/Saghen/blink.cmp
    {
        "saghen/blink.cmp",
        lazy = false, -- lazy loading handled internally
        dependencies = {
            "L3MON4D3/LuaSnip",
            "moyiz/blink-emoji.nvim",
            "fang2hou/blink-copilot",
            --- Colorful Menu (highlight in completions)
            --- https://github.com/xzbdmw/colorful-menu.nvim
            {
                "xzbdmw/colorful-menu.nvim",
                opts = {},
            },
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
                -- Disable cmdline completions
                cmdline = {},
                providers = {
                    -- emoji = { name = "emoji", module = "blink.compat.source" },
                    emoji = {
                        module = "blink-emoji",
                        name = "Emoji",
                        score_offset = 15, -- Tune by preference
                        opts = { insert = true }, -- Insert emoji (default) or complete its name
                    },
                    ecolog = { name = "ecolog", module = "ecolog.integrations.cmp.blink_cmp" },
                    codecompanion = { name = "CodeCompanion", module = "codecompanion.providers.completion.blink" },
                    copilot = {
                        name = "copilot",
                        module = "blink-copilot",
                        score_offset = 100,
                        async = true,
                        opts = {
                            max_completions = 2,
                            max_attempts = 3,
                        },
                    },
                },
            },
            completion = {
                accept = {
                    -- experimental auto-brackets support
                    auto_brackets = {
                        enabled = true,
                    },
                },
                documentation = {
                    -- Controls whether the documentation window will automatically show when selecting a completion item
                    auto_show = true,
                    auto_show_delay_ms = 500,
                },
                list = {
                    selection = {
                        -- auto_insert = true
                        preselect = false,
                    },
                },
                menu = {
                    draw = {
                        -- We don't need label_description now because label and label_description are already
                        -- conbined together in label by colorful-menu.nvim.
                        columns = { { "kind_icon" }, { "label", gap = 1 } },
                        components = {
                            label = {
                                width = { fill = true, max = 60 },
                                text = function(ctx) return require("colorful-menu").blink_components_text(ctx) end,
                                highlight = function(ctx)
                                    return require("colorful-menu").blink_components_highlight(ctx)
                                end,
                            },
                        },
                    },
                },
            },
            snippets = {
                preset = "luasnip",
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
        keys = {
            { "<leader>eg", "<cmd>EcologGoto<cr>", desc = "Go to env file" },
            { "<leader>ep", "<cmd>EcologPeek<cr>", desc = "Ecolog peek variable" },
            { "<leader>es", "<cmd>EcologSelect<cr>", desc = "Switch env file" },
            { "<leader>ke", "<cmd>EcologSnacks<cr>", desc = "Telescope environment variable picker" },
        },
        -- Lazy loading is done internally
        lazy = false,
        opts = {
            load_shell = {
                enabled = true, -- Enable shell variable loading
                override = false, -- When false, .env files take precedence over shell variables
                filter = function(key, value)
                    --- Filter out shell variables that start with '__'
                    return key:match("^__") == nil
                end,
            },
            integrations = {
                blink_cmp = true,
                snacks = {
                    shelter = {
                        mask_on_copy = false, -- Whether to mask values when copying
                    },
                    keys = {
                        copy_value = "<C-y>", -- Copy variable value to clipboard
                        copy_name = "<C-u>", -- Copy variable name to clipboard
                        append_value = "<C-a>", -- Append value at cursor position
                        append_name = "<CR>", -- Append name at cursor position
                    },
                },
            },
            -- Enables shelter mode for sensitive values
            shelter = {
                configuration = {
                    mask_char = "•", -- Character used for masking
                    default_mode = "none",
                    patterns = {
                        ["*_TOKEN"] = "partial", -- Always fully mask TOKEN variables
                        ["*_API_KEY"] = "partial", -- Use partial masking for API keys
                    },
                },
                modules = { --- Mask values in
                    cmp = true,
                    peek = false,
                    files = false,
                    telescope = true,
                    telescope_previewer = true,
                    snacks = true,
                    snacks_previewer = true,
                },
            },
            path = vim.fn.getcwd(), -- Path to search for .env files
        },
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {}, -- this is equalent to setup({}) function
    },
}
