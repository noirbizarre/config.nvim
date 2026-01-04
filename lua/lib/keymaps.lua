return {
    --- Common reusable groups
    { "<leader>b", group = "Buffers", icon = "📔" },
    { "<leader>k", group = "Pickers", icon = "" },
    { "<leader>m", group = "Markdown", icon = "" },
    { "<leader>\\", group = "Multicursor", icon = "" },
    { "<leader>s", group = "Search", icon = "󱈇" },
    { "<leader>t", group = "Test", icon = "󰤑" },
    { "<leader>u", group = "Misc. Utils", icon = "" },

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
        { "<C-a>", "<Esc>ggVG", desc = "Select all content" },
        { "<M-a>", "<cmd>%y<CR>", desc = "Copy all content" },
    },
}
