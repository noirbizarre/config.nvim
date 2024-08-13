return {
    {
        "sindrets/diffview.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        cmd = {
            "DiffviewOpen",
            "DiffviewClose",
            "DiffviewToggleFiles",
            "DiffviewFocusFiles",
        },
    },
    -- Git integration for buffers
    -- https://github.com/lewis6991/gitsigns.nvim
    {
        "lewis6991/gitsigns.nvim",
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {
            
        },
    },
    {
        "linrongbin16/gitlinker.nvim",
        cmd = "GitLink",
        opts = {},
        keys = {
            { "<leader>gy", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Yank git link" },
            { "<leader>gY", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },
        },
    },
}
