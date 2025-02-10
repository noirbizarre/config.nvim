return {
    --- https://github.com/sindrets/diffview.nvim
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
        keys = {
            { "<leader>gD", "<cmd>DiffviewOpen<cr>", desc = "Repo Diffview", nowait = true },
            -- { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "Repo history" },
            -- { "<leader>gf", "<cmd>DiffviewFileHistory --follow %<cr>", desc = "File history" },
            { "<leader>gM", "<cmd>DiffviewOpen main<cr>", desc = "Diff with main" },
        },
    },
    {
        "akinsho/git-conflict.nvim",
        version = "v2.1.0",
        event = "BufRead",
        cmd = {
            "GitConflictChooseOurs",
            "GitConflictChooseTheirs",
            "GitConflictChooseBoth",
            "GitConflictChooseNone",
            "GitConflictNextConflict",
            "GitConflictPrevConflict",
            "GitConflictListQf",
        },
        keys = {
            -- { "]g", "<cmd>GitConflictNextConflict<cr>", desc = "Next Conflict" },
            -- { "[g", "<cmd>GitConflictPrevConflict<cr>", desc = "Previous Conflict" },
            { "<leader>gxq", "<cmd>GitConflictListQf<cr>", desc = "List Conflicts" },
            { "<leader>gxr", "<cmd>GitConflictRefresh<cr>", desc = "Refresh Conflicts" },
            { "<leader>gxo", "<cmd>GitConflictChooseOurs<cr>", desc = "Choose ours" },
            { "<leader>gxt", "<cmd>GitConflictChooseTheirs<cr>", desc = "Choose theirs" },
            { "<leader>gxb", "<cmd>GitConflictChooseBoth<cr>", desc = "Choose both" },
            { "<leader>gxn", "<cmd>GitConflictChooseNone<cr>", desc = "Choose none" },
        },
        config = true,
    },
    -- Git integration for buffers
    -- https://github.com/lewis6991/gitsigns.nvim
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            on_attach = function(bufnr)
                local gitsigns = require("gitsigns")
                local wk = require("which-key")

                wk.add({
                    buffer = bufnr,
                    group = "git",
                    -- Navigation
                    {
                        "]g",
                        function()
                            if vim.wo.diff then
                                vim.cmd.normal({ "]c", bang = true })
                            else
                                gitsigns.nav_hunk("next")
                            end
                        end,
                        desc = "Next hunk",
                    },

                    {
                        "[g",
                        function()
                            if vim.wo.diff then
                                vim.cmd.normal({ "[c", bang = true })
                            else
                                gitsigns.nav_hunk("prev")
                            end
                        end,
                        desc = "Previous hunk",
                    },
                    -- Actions
                    { "<leader>gA", gitsigns.stage_buffer, desc = "Stage buffer" },
                    { "<leader>gR", gitsigns.reset_buffer, desc = "Reset buffer" },
                    { "<leader>ga", gitsigns.stage_hunk, desc = "Stage hunk" },
                    { "<leader>gr", gitsigns.reset_hunk, desc = "Reset hunk" },
                    { "<leader>gu", gitsigns.undo_stage_hunk, desc = "Undo stage hunk" },
                    {
                        "<leader>ga",
                        function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
                        mode = "v",
                        desc = "Stage selection",
                    },
                    {
                        "<leader>gr",
                        function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
                        mode = "v",
                        desc = "Reset selection",
                    },
                })
            end,
        },
    },
    {
        "FabijanZulj/blame.nvim",
        keys = {
            { "<leader>gy", "<cmd>BlameToggle<cr>", desc = "Blame" },
        },
        opts = {},
    },
    -- Octo -- Github Issues & pull requests
    -- https://github.com/pwntester/octo.nvim
    {
        "pwntester/octo.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {},
    },
}
