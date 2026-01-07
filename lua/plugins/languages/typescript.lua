return {
    {
        "noirbizarre/ensure.nvim",
        opts = {
            formatters = {
                javascript = { "prettier" },
                javascriptreact = { "prettier" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },
            },
            lsp = {
                enable = { "vtsls" },
            },
        },
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
}
