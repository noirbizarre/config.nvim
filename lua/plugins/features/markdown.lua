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
    -- Inline Markdown rendering
    -- https://github.com/OXY2DEV/markview.nvim
    {
        "OXY2DEV/markview.nvim",
        -- lazy = false, -- Recommended
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        cmd = {
            "Markview",
            "MarkOpen",
            "CodeCreate",
            "CodeEdit",
            "CheckboxToggle",
        },
        ft = { "markdown", "Avante", "codecompanion", "copilot-chat" },
        keys = {
            { "<leader>mc", "<cmd>CodeCreate<cr>", desc = "Create code block" },
            { "<leader>me", "<cmd>CodeEdit<cr>", desc = "Edit code block" },
            { "<leader>mt", "<cmd>CheckboxToggle<cr>", desc = "Toggle checkbox" },
            { "<leader>m<", function() require("markview.extras.headings").decrease() end, desc = "Decrease heading" },
            { "<leader>m>", function() require("markview.extras.headings").increase() end, desc = "Increase heading" },
        },
        opts = {
            buf_ignore = {},
            filetypes = { "markdown", "Avante", "codecompanion", "copilot-chat" },
            modes = { "n", "i", "no", "c" },
            hybrid_modes = { "i" },

            callbacks = {
                on_enable = function(_, win)
                    vim.wo[win].conceallevel = 2
                    vim.wo[win].concealcursor = "nc"
                end,
            },
            links = {
                inline_links = {
                    hl = "@markup.link.label.markown_inline",
                    icon = " ",
                    icon_hl = "@markup.link",
                },
                images = {
                    hl = "@markup.link.label.markown_inline",
                    icon = " ",
                    icon_hl = "@markup.link",
                },
            },
            code_blocks = {
                style = "language",
                icons = "devicons",
                hl = "ColorColumn",
                info_hl = "ColorColumn",
                pad_amount = 0,
            },
            inline_codes = {
                hl = "RenderMarkdownCode",
                padding_left = 0,
                padding_right = 0,
            },
            list_items = {
                shift_width = 2,
                marker_minus = { text = "●", hl = "@markup.list.markdown" },
                marker_plus = { text = "●", hl = "@markup.list.markdown" },
                marker_star = { text = "●", hl = "@markup.list.markdown" },
                marker_dot = {},
            },
            -- inline_codes = { enable = false },
            headings = {
                heading_1 = { hl = "DiffAdd", icon_hl = "DiffAdd" },
                heading_2 = { hl = "DiffChange", icon_hl = "DiffChange" },
                heading_3 = { hl = "DiffDelete", icon_hl = "@markup.heading.3.markdown" },
                heading_4 = { hl = "DiffDelete", icon_hl = "@markup.heading.4.markdown" },
                heading_5 = { hl = "DiffDelete", icon_hl = "@markup.heading.5.markdown" },
                heading_6 = { hl = "DiffDelete", icon_hl = "@markup.heading.6.markdown" },
            },
        },
        config = function(_, opts)
            require("markview").setup(opts)
            ---@diagnostic disable: missing-fields
            require("markview.extras.checkboxes").setup({})
            require("markview.extras.editor").setup({
                width = { 0.2, 0.75 },
                height = { 0.2, 0.75 },
            })
        end,
    },
}
