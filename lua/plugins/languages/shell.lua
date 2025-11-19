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

local LSPs = {
    "bashls",
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
                sh = { "shfmt" },
            },
        },
    },
}
