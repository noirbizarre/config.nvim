return {
    --- Common reusable groups
    { "<leader>b", group = "Buffers", icon = "📔" },
    { "<leader>a", group = "AI", icon = "" },
    { "<leader>d", group = "Debug", icon = "" },
    { "<leader>g", group = "Git", icon = "" },
    { "<leader>gx", group = "Git conflicts", icon = "" },
    { "<leader>k", group = "Pickers", icon = "" },
    { "<leader>m", group = "Markdown", icon = "" },
    { "<leader>\\", group = "Multicursor", icon = "" },
    { "<leader>s", group = "Search", icon = "󱈇" },
    { "<leader>t", group = "Test", icon = "󰤑" },
    { "<leader>u", group = "Misc. Utils", icon = "" },
    { "<leader>x", group = "Trouble", icon = "🚦" },

    {
        group = "Session",
        {
            "<leader>QQ",
            "<cmd>qa!<cr>",
            mode = { "n", "v" },
            desc = "Quit without saving",
            icon = { icon = "󰈆", color = "red" },
        },
        {
            "<leader><esc><esc>",
            "<cmd>qa!<cr>",
            mode = { "n", "v" },
            desc = "Quit without saving",
            icon = { icon = "󰈆", color = "red" },
        },
    },

    { "<leader>l", group = "LSP", icon = "󰘦" },
    {
        group = "LSP",
        { "<leader>lh", function() vim.lsp.buf.hover() end, desc = "Hover", icon = "" },
        { "<leader>lr", function() vim.lsp.buf.rename() end, desc = "Rename", icon = "" },
        { "<leader>la", function() vim.lsp.buf.code_action() end, desc = "Code Action", icon = "" },
        {
            "<leader>li",
            function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 }) end,
            desc = "Toggle LSP inlays",
            icon = "",
        },
    },

    { "<leader>r", group = "Refactoring", icon = "󰑕" },
    {
        group = "Refactoring",
        { "<leader>rs", ":'<,'>sort<cr>", mode = "x", desc = "Sort (Alpha ASC)", icon = "" },
        { "<leader>rS", ":'<,'>sort!<cr>", mode = "x", desc = "Sort (Alpha DESC)", icon = "" },
        { "<leader>rn", ":'<,'>sort n<cr>", mode = "x", desc = "Sort (Num ASC)", icon = "" },
        { "<leader>rN", ":'<,'>sort! n<cr>", mode = "x", desc = "Sort (Num DESC)", icon = "" },
    },

    { "<leader>q", group = "Quickfix", icon = "󱒋" },
    {
        group = "Quickfix",
        { "<leader>qo", "<cmd>copen<cr>", desc = "Open quickfix list", icon = "󱒋" },
        { "<leader>qc", "<cmd>cclose<cr>", desc = "Close quickfix list", icon = "󱒋" },
        { "<leader>qn", "<cmd>cnext<cr>", desc = "Next quickfix item", icon = "󰮱" },
        { "<leader>qN", "<cmd>cprev<cr>", desc = "Previous quickfix item", icon = "󰮳" },
    },

    -- Terminal
    {
        mode = "t",
        { "<Esc>", proxy = "<C-\\><C-n>", desc = "Exit terminal mode" },
    },

    -- Hidden hacks
    {
        hidden = true,
        { "<Esc>", "<cmd>nohls<CR>", desc = "Clear search highlighting" },
    },
}
