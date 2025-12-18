return {
    "noirbizare/ensure.nvim",
    opts = {
        linters = {
            dockerfile = { "hadolint" },
        },
        formatters = {
            dockerfile = { "dockerfmt" },
        },
        lsp = {
            enable = { "dockerls", "docker_compose_language_service" },
            dockerls = {
                settings = {
                    docker = {
                        languageserver = {
                            formatter = {
                                ignoreMultilineInstructions = true,
                            },
                        },
                    },
                },
            },
        },
    },
}
