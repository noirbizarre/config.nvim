vim.filetype.add({
    extension = {
        wiz = "yaml",
    },
})

return {
    "noirbizare/ensure.nvim",
    opts = {
        formatters = {
            yaml = { "prettier" },
        },
        lsp = {
            enable = { "yamlls" },
            yamlls = function()
                local schema_companion = require("schema-companion")
                return schema_companion.setup_client(
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
                    ---@diagnostic disable-next-line: missing-fields
                    {
                        settings = {
                            yaml = {
                                validate = true,
                            },
                        },
                    }
                )
            end,
        },
    },
}
