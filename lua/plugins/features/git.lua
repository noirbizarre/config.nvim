return {
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
            { "]x", "<cmd>GitConflictNextConflict<cr>", desc = "Next Conflict" },
            { "[x", "<cmd>GitConflictPrevConflict<cr>", desc = "Previous Conflict" },
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
        keys = {
            { "<leader>gY", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle line blame" },
            { "<leader>gy", "<cmd>Gitsigns blame<cr>", desc = "Blame" },
        },
        opts = {
            current_line_blame_opts = {
                virt_text_pos = "right_align",
                delay = 100,
            },
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
    -- Octo -- Github Issues & pull requests
    {
        "pwntester/octo.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            picker = "snacks",
        },
    },
}
