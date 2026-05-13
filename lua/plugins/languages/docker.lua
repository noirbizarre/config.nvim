return {
    "noirbizarre/ensure.nvim",
    opts = {
        parsers = { disable = { "dockerfile" } },
        linters = {
            dockerfile = { "hadolint" },
        },
        formatters = {
            -- TODO: ask for Mason publication of dockerfmt
            -- dockerfile = { "dockerfmt" },
        },
        lsp = {
            enable = { "docker_language_server" },
            -- dockerls = {
            --     settings = {
            --         docker = {
            --             languageserver = {
            --                 formatter = {
            --                     ignoreMultilineInstructions = true,
            --                 },
            --             },
            --         },
            --     },
            -- },
        },
    },
}
