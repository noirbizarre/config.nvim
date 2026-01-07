return {
    "noirbizarre/ensure.nvim",
    opts = {
        linters = {
            terraform = { "tflint" },
        },
        lsp = {
            enable = { "terraformls" },
        },
    },
}
