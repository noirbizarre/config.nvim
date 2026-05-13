return {
    {
        "mrcjkb/rustaceanvim",
        lazy = false, -- This plugin is already lazy
        config = function()
            ---@type rustaceanvim.Opts
            vim.g.rustaceanvim = {
                tools = {
                    code_actions = {
                        ui_select_fallback = true,
                    },
                    float_win_config = {
                        auto_focus = true,
                    },
                },
            }
        end,
    },
    {
        "nvim-neotest/neotest",
        ft = "rust",
        opts = function(_, opts) table.insert(opts.adapters, require("rustaceanvim.neotest")) end,
    },
    {
        "noirbizarre/ensure.nvim",
        opts = {
            formatters = {
                rust = { "rustfmt" },
            },
            ignore = {
                packages = { "rustfmt" },
            },
            lsp = {
                auto = {
                    ignore = {
                        rust = "*",
                    },
                },
            },
        },
    },
}
