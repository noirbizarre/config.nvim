return {
    --- Common reusable groups
    { "<leader>a", group = "Avante", icon = "󱚣" },
    { "<leader>b", group = "Buffers", icon = "📔" },
    { "<leader>c", group = "CodeCompanion", icon = "" },
    { "<leader>d", group = "Debug", icon = "" },
    { "<leader>g", group = "Git", icon = "" },
    { "<leader>h", group = "Harpoon", icon = "" },
    { "<leader>i", group = "CoPilot", icon = "" },
    { "<leader>k", group = "Telescope", icon = "" },
    { "<leader>m", group = "Multicursor", icon = "" },
    { "<leader>s", group = "Search", icon = "󱈇" },
    { "<leader>t", group = "Test", icon = "󰤑" },
    { "<leader>x", group = "Trouble", icon = "🚦" },

    {
        group = "Clipboard",
        { "<leader>y", '"+y', mode = "v", desc = "Copy to system clipboard", icon = "󰆏" },
        { "<leader>p", '"+p', mode = { "n", "v" }, desc = "Paste from system clipboard", icon = "" },
    },

    {
        group = "Session",
        { "<leader>qq", "<cmd>qa!<cr>", mode = { "n", "v" }, desc = "Quit without saving", icon = "󰈆" },
    },

    { "<leader>l", group = "LSP", icon = "󰘦" },
    {
        group = "LSP",
        { "<leader>lh", function() vim.lsp.buf.hover() end, desc = "Hover" },
        { "<leader>lr", function() vim.lsp.buf.rename() end, desc = "Rename" },
    },

    { "<leader>r", group = "Refactoring", icon = "󰑕" },
    {
        group = "Refactoring",
        { "<leader>rs", ":'<,'>sort<cr>", mode = "x", desc = "Sort (Alpha ASC)", icon = "" },
        { "<leader>rS", ":'<,'>sort!<cr>", mode = "x", desc = "Sort (Alpha DESC)", icon = "" },
        { "<leader>rn", ":'<,'>sort n<cr>", mode = "x", desc = "Sort (Num ASC)", icon = "" },
        { "<leader>rN", ":'<,'>sort! n<cr>", mode = "x", desc = "Sort (Num DESC)", icon = "" },
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
