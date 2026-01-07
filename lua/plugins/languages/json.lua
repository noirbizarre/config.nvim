vim.filetype.add({
    pattern = {
        -- VSCode JSONC
        [".*/%.vscode/.+%.json"] = "jsonc",
    },
})

return {
    "noirbizarre/ensure.nvim",
    dependencies = {
        "b0o/schemastore.nvim",
    },
    opts = {
        parsers = {
            "jq",
            "json",
            "json5",
            "jsonc",
        },
        linters = {
            json = { "jsonlint" },
        },
        formatters = {
            json = { "prettier" },
            jsonc = { "prettier" },
        },
        lsp = {
            enable = { "jsonls" },
            jsonls = function()
                return {
                    settings = {
                        json = {
                            schemas = require("schemastore").json.schemas(),
                            validate = { enable = true },
                        },
                    },
                }
            end,
        },
    },
}
