return {
    -- {
    --     "noirbizare/ensure.nvim",
    --     opts = {
    --         -- parsers = {
    --         --     "markdown",
    --         --     "markdown_inline",
    --         -- },
    --         linters = {
    --             markdown = { "vale" },
    --         },
    --         formatters = {
    --             markdown = { "markdownlint-cli2" },
    --         },
    --         lsp = {
    --             enable = {"marksman"},
    --         },
    --     },
    -- },
    -- {
    --     "nvim-treesitter/nvim-treesitter",
    --     opts = {
    --         ensure_installed = {"go", "gomod", "gosum", "gotmpl"},
    --     },
    -- },
    {
        "nvim-neotest/neotest",
        ft = "go",
        dependencies = {
            "nvim-neotest/neotest-go",
        },
        opts = function(_, opts) table.insert(opts.adapters, require("neotest-go")) end,
    },
}
