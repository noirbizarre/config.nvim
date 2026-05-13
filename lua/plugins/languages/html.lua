vim.filetype.add({
    extension = {
        -- See: https://documentation.mjml.io/
        mjml = "xml",
    },
})

return {
    "noirbizarre/ensure.nvim",
    opts = {
        formatters = {
            html = { "prettier" },
        },
    },
}
