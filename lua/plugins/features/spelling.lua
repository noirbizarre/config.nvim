return {
    "noirbizarre/ensure.nvim",
    dependencies = {
        "barreiroleo/ltex_extra.nvim",
        branch = "dev",
        -- ft = { "markdown", "tex" },
        opts = {
            load_langs = { "en-US", "fr-FR" },
        },
    },
    opts = {
        formatters = {
            ["*"] = { "codespell" },
        },
        lsp = {
            enable = { "codebook", "harper_ls" },
            harper_ls = {
                settings = {
                    ["harper-ls"] = {
                        linters = {
                            SpellCheck = false,
                        },
                    },
                },
            },
            ltex_plus = {
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
            },
        },
    },
}
