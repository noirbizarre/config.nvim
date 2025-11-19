local LSPs = {
    "gh_actions_ls",
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
        opts = function()
            vim.lsp.enable(LSPs)
            vim.lsp.config("gh_actions_ls", {
                init_options = {
                    sessionToken = vim.env.GITHUB_TOKEN,
                },
            })
        end,
    },
}
