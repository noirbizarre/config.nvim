local LSPs = {
    "tombi",
    -- "taplo",
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

    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                toml = { "tombi" },
            },
        },
    },
}
