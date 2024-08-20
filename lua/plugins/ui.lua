return {
    --- Top bufferline/tabline
    --- https://github.com/akinsho/bufferline.nvim
    {
        "akinsho/bufferline.nvim",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        keys = {
            {"<S-Left>", "<cmd>BufferLineCyclePrev<cr>", desc="Next buffer"},
            {"<S-Right>", "<cmd>BufferLineCycleNext<cr>", desc="Previous buffer"},
            {"<C-S-Left>", "<cmd>BufferLineMovePrev<cr>", desc="Move to next buffer"},
            {"<C-S-Right>", "<cmd>BufferLineMoveNext<cr>", desc="Move to previous buffer"},
        },
        opts = {
            options = {
                diagnostics = "nvim_lsp",
                always_show_bufferline = false,
                offsets = {
                    { filetype = "NvimTree", text = "", padding = 1 },
                    { filetype = "neo-tree", text = "", padding = 1 },
                    { filetype = "Outline", text = "", padding = 1 },
                },
            }
        },
    },

    -- {
    --     'Bekaboo/dropbar.nvim',
    --     enabled = system.isNeovimVersionsatisfied(10),
    --     event = { "BufReadPost", "BufNewFile" },
    --     -- optional, but required for fuzzy finder support
    --     dependencies = {
    --         'nvim-telescope/telescope-fzf-native.nvim'
    --     },
    -- },

    {
        'nvimdev/lspsaga.nvim',
        cmd = "LspSaga",
        event = { "BufReadPost", "BufNewFile" },
        keys = {
            {'<leader>li', '<cmd>Lspsaga incoming_calls<cr>', desc="Incoming calls"},
            {'<leader>lo', '<cmd>Lspsaga outgoing_calls<cr>', desc="Outgoing calls"},
            {'<leader>la', '<cmd>Lspsaga code_action<cr>', desc="Code Action"},
            {'<leader>lr', '<cmd>Lspsaga rename<cr>', desc="Rename"},
            {'<leader>lt', '<cmd>Lspsaga outline<cr>', desc="Outline"},
            {'<leader>lp', '<cmd>Lspsaga peek_definition<cr>', desc="Peek definition"},
            {'<leader>lg', '<cmd>Lspsaga goto_definition<cr>', desc="Go to definition"},
            {'<leader>lpt', '<cmd>Lspsaga peek_type_definition<cr>', desc="Peek type definition"},
            {'<leader>lgt', '<cmd>Lspsaga goto_type_definition<cr>', desc="Go to type definition"},
            {'<leader>lh', '<cmd>Lspsaga hover_doc<cr>', desc="Toggle hover documentation"},
        },
        opts = {
            lightbulb = {
                enable = false,
            }
        },
        dependencies = {
            'nvim-treesitter/nvim-treesitter', -- optional
            'nvim-tree/nvim-web-devicons',     -- optional
        },
    },

    --- Bottom status bar
    --- https://github.com/nvim-lualine/lualine.nvim
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "someone-stole-my-name/yaml-companion.nvim",
        },
        event = "VeryLazy",
        config = function()
            -- https://github.com/someone-stole-my-name/yaml-companion.nvim#get-the-schema-name-for-the-current-buffer
            local function get_schema()
                local schema = require("yaml-companion").get_buf_schema(0)
                if schema.result[1].name == "none" then
                    return ""
                end
                return schema.result[1].name
            end

            icons = require("config.ui").icons
            require("lualine").setup({
                options = {
                    -- theme = "nightfox",
                    -- theme = "solarized_dark",
                    section_separators = icons.ui.powerline.separators,
                    component_separators = icons.ui.powerline.inner_separators,
                    icons_enabled = true,
                    globalstatus = true,
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch" },
                    lualine_c = {
                        "diff",
                        { "diagnostics", sources = { "nvim_diagnostic" } },
                        "overseer",
                    },
                    lualine_x = {
                        "searchcount",
                        "filetype",
                        "fileformat",
                        "encoding",
                        get_schema,
                    },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = { "location" },
                },
                extensions = { "quickfix", "toggleterm", "man" },
            })
        end
    },
}
