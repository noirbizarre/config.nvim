local bufnr = vim.api.nvim_get_current_buf()
local wk = require("which-key")

wk.add({
    buffer = bufnr,
    group = "Rust",
    {
        "<leader>la",
        function()
            vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
        end,
        desc = "Code Action",
    },
    {
        "<leader>lh",
        function()
            -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
            vim.cmd.RustLsp({ "hover", "actions" })
        end,
        desc = "Hover",
    },
    {
        "<leader>lC",
        function() vim.cmd.RustLsp("openCargo") end,
        desc = "Cargo.toml",
    },
    {
        "<leader>lD",
        function() vim.cmd.RustLsp("openDocs") end,
        desc = "Go to Docs.rs",
    },
    {
        "<leader>le",
        function() vim.cmd.RustLsp("explainError") end,
        desc = "Explain error",
    },
    {
        "<leader>lR",
        function() vim.cmd.RustLsp("relatedDiagnostics") end,
        desc = "Jump to related diagnostics",
    },
})
