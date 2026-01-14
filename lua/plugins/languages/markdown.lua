local filetypes = { "markdown", "Avante", "codecompanion", "copilot-chat", "opencode_output" }

return {
    {
        "noirbizarre/ensure.nvim",
        opts = {
            linters = { markdown = "vale" },
            formatters = { markdown = "markdownlint-cli2" },
            lsp = {
                enable = { "marksman" },
            },
        },
    },
    {
        "craftzdog/solarized-osaka.nvim",
        opts = {
            highlights = {
                ["@markup.heading"] = function(highlights, colors)
                    local util = require("solarized-osaka.util")
                    highlights["@markup.heading.1"] = {
                        fg = colors.blue,
                        bg = util.blend(colors.blue, colors.bg, 0.25),
                        bold = true,
                    }
                    highlights["@markup.heading.2"] = {
                        fg = colors.orange,
                        bg = util.blend(colors.orange100, colors.bg, 0.25),
                        bold = true,
                    }
                    highlights["@markup.heading.3"] = {
                        fg = colors.yellow,
                        bg = util.blend(colors.yellow, colors.bg, 0.25),
                        bold = true,
                    }
                    highlights["@markup.heading.4"] = {
                        fg = colors.green,
                        bg = util.blend(colors.green, colors.bg, 0.25),
                        bold = true,
                    }
                    highlights["@markup.heading.5"] = {
                        fg = colors.magenta,
                        bg = util.blend(colors.magenta100, colors.bg, 0.25),
                        bold = true,
                    }
                    highlights["@markup.heading.6"] = {
                        fg = colors.violet,
                        bg = util.blend(colors.violet, colors.bg, 0.25),
                        bold = true,
                    }

                    return { fg = colors.cyan, bg = util.blend(colors.cyan, colors.bg, 0.25) }
                end,
            },
        },
    },
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
            "Editor",
            "Checkbox",
        },
        ft = filetypes,
        keys = {
            { "<leader>mc", function() require("markview.extras.editor").create() end, desc = "Create code block" },
            { "<leader>me", function() require("markview.extras.editor").edit() end, desc = "Edit code block" },
            { "<leader>mt", "<cmd>Checkbox toggle<cr>", desc = "Toggle checkbox" },
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
                    heading_1 = { hl = "@markup.heading.1.markdown", icon_hl = "@markup.heading.1.markdown" },
                    heading_2 = { hl = "@markup.heading.2.markdown", icon_hl = "@markup.heading.2.markdown" },
                    heading_3 = { hl = "@markup.heading.3.markdown", icon_hl = "@markup.heading.3.markdown" },
                    heading_4 = { hl = "@markup.heading.4.markdown", icon_hl = "@markup.heading.4.markdown" },
                    heading_5 = { hl = "@markup.heading.5.markdown", icon_hl = "@markup.heading.5.markdown" },
                    heading_6 = { hl = "@markup.heading.6.markdown", icon_hl = "@markup.heading.6.markdown" },
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
}
