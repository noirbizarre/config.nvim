local LSPs = {
    "vtsls",
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
        "nvim-neotest/neotest",
        dependencies = {
            "haydenmeade/neotest-jest",
        },
        ft = {
            "javascript",
            "javascript.jsx",
            "javascriptreact",
            "typescript",
            "typescript.tsx",
            "typescriptreact",
        },
        opts = function(_, opts) table.insert(opts.adapters, require("neotest-jest")) end,
    },
    {
        "stevearc/conform.nvim",
        opts = {
            javascript = { "prettier" },
            javascriptreact = { "prettier" },
            typescript = { "prettier" },
            typescriptreact = { "prettier" },
        },
    },
}
