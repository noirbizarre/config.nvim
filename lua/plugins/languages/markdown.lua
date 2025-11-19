local filetypes = { "markdown", "Avante", "codecompanion", "copilot-chat", "opencode_output" }
local LSPs = {
    "marksman",
}

return {
    -- Inline Markdown rendering
    {
        "OXY2DEV/markview.nvim",
        dev = false,
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
        ft = filetypes,
        keys = {
            { "<leader>mc", "<cmd>CodeCreate<cr>", desc = "Create code block" },
            { "<leader>me", "<cmd>CodeEdit<cr>", desc = "Edit code block" },
            { "<leader>mt", "<cmd>CheckboxToggle<cr>", desc = "Toggle checkbox" },
            { "<leader>m<", function() require("markview.extras.headings").decrease() end, desc = "Decrease heading" },
            { "<leader>m>", function() require("markview.extras.headings").increase() end, desc = "Increase heading" },
        },
        opts = {
            preview = {
                ignore_buftypes = {},
                filetypes = filetypes,
                modes = { "n", "i", "no", "c" },
                hybrid_modes = { "n", "i" },
                linewise_hybrid_mode = true,
                icon_provider = "devicons",
            },
            markdown = {
                code_blocks = {
                    default = {
                        block_hl = "ColorColumn",
                        pad_hl = "ColorColumn",
                    },
                    border_hl = "ColorColumn",
                    info_hl = "ColorColumn",
                    pad_amount = 0,
                },
                headings = {
                    heading_1 = { hl = "DiffAdd", icon_hl = "DiffAdd" },
                    heading_2 = { hl = "DiffChange", icon_hl = "DiffChange" },
                    heading_3 = { hl = "DiffDelete", icon_hl = "@markup.heading.3.markdown" },
                    heading_4 = { hl = "DiffDelete", icon_hl = "@markup.heading.4.markdown" },
                    heading_5 = { hl = "DiffDelete", icon_hl = "@markup.heading.5.markdown" },
                    heading_6 = { hl = "DiffDelete", icon_hl = "@markup.heading.6.markdown" },
                },
                list_items = {
                    shift_width = 2,
                    marker_minus = { text = "●", hl = "@markup.list.markdown" },
                    marker_plus = { text = "●", hl = "@markup.list.markdown" },
                    marker_star = { text = "●", hl = "@markup.list.markdown" },
                    marker_dot = {},
                },
            },
            markdown_inline = {
                hyperlinks = {
                    default = {
                        hl = "@markup.link.label.markown_inline",
                    },
                },
                images = {
                    default = {
                        hl = "@markup.link.label.markown_inline",
                    },
                },
                inline_codes = {
                    hl = "RenderMarkdownCode",
                    padding_left = 0,
                    padding_right = 0,
                },
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
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = LSPs,
        },
    },
    {
        "neovim/nvim-lspconfig",
        opts = function() vim.lsp.enable(LSPs) end,
    },
    {
        "mfussenegger/nvim-lint",
        opts = {
            linters_by_ft = {
                markdown = { "vale" },
            },
        },
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                markdown = { "markdownlint-cli2" },
            },
        },
    },
}
