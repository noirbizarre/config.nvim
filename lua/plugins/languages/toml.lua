-- TODO: Get tombi current schema as soon as support is provided

return {
    "noirbizarre/ensure.nvim",
    opts = {
        formatters = { toml = "tombi" },
        lsp = {
            enable = { "tombi" },
        },
    },
}
