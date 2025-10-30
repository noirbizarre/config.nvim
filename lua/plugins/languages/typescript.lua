return {
    {
        "neovim/nvim-lspconfig",
        config = function() vim.lsp.enable("vtsls") end,
    },
}
