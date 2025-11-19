vim.filetype.add({
    pattern = {
        [".*/templates/.+%.yaml"] = "helm",
    },
})

local LSPs = {
    "helm_ls",
}

return {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = LSPs,
        },
    },
    {
        "neovim/nvim-lspconfig",
        opts = function() vim.lsp.enable(LSPs) end,
    },
}
