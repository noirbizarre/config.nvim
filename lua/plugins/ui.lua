-- local system = require("lib.system")

return {
    --- Top bufferline/tabline
    --- https://github.com/akinsho/bufferline.nvim
    {
        "akinsho/bufferline.nvim",
        lazy = false,
        branch = "v3.0.0",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        keys = {
            {"<S-Left>", "<cmd>BufferLineCyclePrev<cr>", desc="Next buffer"},
            {"<S-Right>", "<cmd>BufferLineCycleNext<cr>", desc="Previous buffer"},
            {"<C-S-Left>", "<cmd>BufferLineMovePrev<cr>", desc="Move to next buffer"},
            {"<C-S-Right>", "<cmd>BufferLineMoveNext<cr>", desc="Move to previous buffer"},
        },
        config = function()
            require("bufferline").setup{
                options = {
                    diagnostics = "nvim_lsp",
                    always_show_bufferline = false,
                    offsets = {
                        { filetype = "NvimTree", text = "", padding = 1 },
                        { filetype = "neo-tree", text = "", padding = 1 },
                        { filetype = "Outline", text = "", padding = 1 },
                    },
                }
            }
        end,
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
            {'<C-S-i', '<cmd>Lspsaga code_action<cr>', desc="Code Action"},
            {'<C-S-r', '<cmd>Lspsaga rename<cr>', desc="Rename"},
            -- {'<C-S-I', '<cmd>Lspsaga hover_doc<cr>', desc="Hover Documentation"},
        },
        opts = {
            lightbulb = {
                enable = false,
            }
        },
        -- config = function()
        --     require('lspsaga').setup({})
        -- end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter', -- optional
            'nvim-tree/nvim-web-devicons',     -- optional
        },
    },

    --- Floating winbar
    --- https://github.com/b0o/incline.nvim
    -- {
    --     "b0o/incline.nvim",
    --     event = "BufReadPre",
    --     config = function()
    --         require("incline").setup()
    --         -- local colors = require("nightfox.colors").setup()
    --         -- require("incline").setup({
    --         --     highlight = {
    --         --     groups = {
    --         --         InclineNormal = { guibg = "#FC56B1", guifg = colors.black },
    --         --         InclineNormalNC = { guifg = "#FC56B1", guibg = colors.black },
    --         --     },
    --         --     },
    --         --     window = { margin = { vertical = 0, horizontal = 1 } },
    --         --     render = function(props)
    --         --     local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
    --         --     local icon, color = require("nvim-web-devicons").get_icon_color(filename)
    --         --     return { { icon, guifg = color }, { " " }, { filename } }
    --         --     end,
    --         -- })
    --     end,
    -- },

    --- Bottom status bar
    --- https://github.com/nvim-lualine/lualine.nvim
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        event = "VeryLazy",
        config = function()
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
