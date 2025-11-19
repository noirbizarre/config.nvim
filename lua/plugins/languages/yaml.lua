vim.filetype.add({
    extension = {
        wiz = "yaml",
    },
})

return {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = { "yamlls" },
        },
    },
    {
        "neovim/nvim-lspconfig",
        opts = function()
            local schema_companion = require("schema-companion")

            vim.lsp.enable("yamlls")
            vim.lsp.config(
                "yamlls",
                schema_companion.setup_client(
                    schema_companion.adapters.yamlls.setup({
                        sources = {
                            schema_companion.sources.matchers.kubernetes.setup({ version = "master" }),
                            schema_companion.sources.lsp.setup(),
                            schema_companion.sources.schemas.setup({
                                {
                                    uri = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json",
                                    name = "Argo CD Application",
                                    description = "Argo CD Application Schema (v1alpha1)",
                                    fileMatch = "argocd-application.yaml",
                                },
                            }),
                        },
                    }),
                    {
                        settings = {
                            yaml = {
                                validate = true,
                            },
                        },
                    }
                )
            )
        end,
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                yaml = { "prettier" },
            },
        },
    },
}
