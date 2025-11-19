vim.filetype.add({
    pattern = {
        -- VSCode JSONC
        [".*/%.vscode/.+%.json"] = "jsonc",
    },
})

return {
    {
        "mason-org/mason-lspconfig.nvim",
        ensure_installed = {
            "jsonls",
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "b0o/schemastore.nvim",
        },
        opts = function()
            vim.lsp.enable({
                "jsonls",
            })
            vim.lsp.config("jsonls", {
                settings = {
                    json = {
                        schemas = require("schemastore").json.schemas(),
                        validate = { enable = true },
                    },
                },
            })
        end,
    },
    {
        "mfussenegger/nvim-lint",
        opts = {
            linters_by_ft = {
                json = { "jsonlint" },
            },
        },
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                json = { "prettier" },
                jsonc = { "prettier" },
            },
        },
    },
}
