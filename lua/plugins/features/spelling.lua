return {
    "noirbizare/ensure.nvim",
    dependencies = {
        "barreiroleo/ltex_extra.nvim",
        branch = "dev",
        -- ft = { "markdown", "tex" },
        opts = {
            load_langs = { "en-US", "fr-FR" },
        },
    },
    opts = {
        lsp = {
            enable = { "ltex_plus" },
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
