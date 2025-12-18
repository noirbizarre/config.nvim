vim.filetype.add({
    pattern = {
        [".*/templates/.+%.yaml"] = "helm",
    },
})

return {
    "noirbizare/ensure.nvim",
    opts = {
        linters = {
            markdown = { "vale" },
        },
        formatters = {
            markdown = { "markdownlint-cli2" },
        },
        lsp = {
            enable = { "helm_ls" },
        },
    },
}
