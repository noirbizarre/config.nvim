local LSPs = { "dockerls", "docker_compose_language_service" }

return {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = LSPs,
        },
    },
    {
        "neovim/nvim-lspconfig",
        opts = function()
            vim.lsp.enable(LSPs)

            vim.lsp.config("dockerls", {
                settings = {
                    docker = {
                        languageserver = {
                            formatter = {
                                ignoreMultilineInstructions = true,
                            },
                        },
                    },
                },
            })
        end,
    },
    {
        "mfussenegger/nvim-lint",
        opts = {
            linters_by_ft = {
                dockerfile = { "hadolint" },
            },
        },
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                dockerfile = { "dockerfmt" },
            },
        },
    },
}
