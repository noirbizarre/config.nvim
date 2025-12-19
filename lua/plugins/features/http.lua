return {
    "mistweaverco/kulala.nvim",
    keys = {
        { "<leader>Rs", desc = "Send request" },
        { "<leader>Ra", desc = "Send all requests" },
        { "<leader>Rb", desc = "Open scratchpad" },
        { "<leader>Ro", desc = "Open scratchpad" },
    },
    ft = { "http", "rest" },
    opts = {
        -- your configuration comes here
        global_keymaps = true,
        global_keymaps_prefix = "<leader>R",
        kulala_keymaps_prefix = "",
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters = {
                kulala = {
                    command = "kulala-fmt",
                    args = { "format", "$FILENAME" },
                    stdin = false,
                },
            },
            formatters_by_ft = {
                graphql = { "prettier" },
                http = { "kulala" },
            },
        },
    },
        {
            "noibizarre/ensure.nvim",
            opts = {
                ignore = {
                    packages = {"kulala"}
                },
            },
        },
}
