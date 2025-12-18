return {
    "noirbizarre/ensure.nvim",
    opts = {
        lsp = {
            enable = { "gh_actions_ls" },
            gh_actions_ls = {
                init_options = {
                    sessionToken = vim.env.GITHUB_TOKEN,
                },
            },
        },
    },
}
