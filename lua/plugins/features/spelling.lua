local LSPs = {
    "ltex_plus",
}

return {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = LSPs,
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "barreiroleo/ltex_extra.nvim",
                branch = "dev",
                -- ft = { "markdown", "tex" },
                opts = {
                    load_langs = { "en-US", "fr-FR" },
                },
            },
        },
        opts = function()
            vim.lsp.enable(LSPs)
            vim.lsp.config("ltex_plus", {
                settings = {
                    ltex = {
                        checkFrequency = "save",
                        language = { "en-US", "fr" },
                        additionalRules = {
                            enablePickyRules = true,
                            motherTongue = { "fr" },
                        },
                    },
                },
            })
        end,
    },
}
