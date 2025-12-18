vim.filetype.add({
    extension = {
        alias = "sh",
    },
    pattern = {
        [".*/kitty/.+%.conf"] = "kitty",
        -- dotfiles
        [".*/%.local/bin/*"] = "sh",
        [".*/%.alias%.d/.+%.alias"] = "sh",
        [".*/%.env%.d/.+%.path"] = "sh",
        [".*/%.config/tmux/.+%.conf"] = "tmux",
        -- ["%.env%.[%w_.-]+"] = "sh",
        [".*/.+%.secret"] = "sh",
    },
})

vim.treesitter.language.register("bash", "kitty")

return {
    {
        "noibizarre/ensure.nvim",
        opts = {
            parsers = {
                "bash",
            },
            formatters = {
                sh = { "shfmt" },
            },
            lsp = {
                enable = {
                    "bashls",
                },
            },
        },
    },
}
