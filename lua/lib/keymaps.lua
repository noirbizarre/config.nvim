return {
    --- Common reusable groups
    { "<leader>a", group = "Avante", icon = "󱚣" },
    { "<leader>c", group = "CodeCompanion", icon = "" },
    { "<leader>d", group = "Debug", icon = "" },
    { "<leader>k", group = "Telescope", icon = "" },
    { "<leader>g", group = "Git", icon = ""},
    { "<leader>l", group = "LSP", icon = "󰘦" },
    { "<leader>r", group = "Refactoring", icon = "󰑕" },
    { "<leader>s", group = "Search", icon = "󱈇" },
    { "<leader>t", group = "Test", icon = "󰤑" },

    {
        group = "Clipboard",
        { "<leader>y", '"+y', mode = "v", desc = "Copy to system clipboard", icon = "󰆏" },
        { "<leader>p", '"+p', mode = {"n", "v"}, desc = "Paste from system clipboard", icon = ""},
    },

    {
        group = "Session",
        { "<leader>qq", "<cmd>qa!<cr>", mode = { "n", "v" }, desc = "Quit without saving", icon = "󰈆" },
    },

    {
        group = "Refactoring",
        { "<leader>rs", "<cmd>sort<cr>", mode = "v", desc = "Sort (Alpha ASC)", icon = "" },
        { "<leader>rS", "<cmd>sort!<cr>", mode = "v", desc = "Sort (Alpha DESC)", icon = "" },
        { "<leader>rn", "<cmd>sort n<cr>", mode = "v", desc = "Sort (Num ASC)", icon = "" },
        { "<leader>rN", "<cmd>sort! n<cr>", mode = "v", desc = "Sort (Num DESC)", icon = "" },
    },

    -- Hidden hacks
    {
        hidden = true,
        { "<Esc>", "<cmd>nohls<CR>", desc = "Clear search highlighting"},
    },
}
