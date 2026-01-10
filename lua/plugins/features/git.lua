local gitwin = { win = { width = 0.4, height = 0.4 } }

function git_commit() Snacks.terminal("git commit", gitwin) end

return {
    {
        "folke/which-key.nvim",
        opts = {
            spec = {
                { "<leader>g", group = "Git", icon = { icon = "", color = "red" } },
                { "<leader>gc", group = "Git commit", icon = { icon = "", color = "green" } },
                { "<leader>gx", group = "Git conflicts", icon = "💥" },
            },
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
    -- VSCode-like diff viewer
    {
        "esmuellert/codediff.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
        cmd = "CodeDiff",
    },
    -- Git integration for buffers
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
    --- Pickers
    {
        "folke/snacks.nvim",
        keys = {
            { "<leader>gh", function() Snacks.picker.git_log() end, desc = "History" },
            { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Current buffer history" },
            { "<leader>gl", function() Snacks.picker.git_log_line() end, desc = "Current line history" },
            { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
            { "<leader>gt", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
            { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
            { "<leader>gB", function() Snacks.picker.git_branches({ all = true }) end, desc = "Git Branches (all)" },
            { "<leader>gd", function() Snacks.picker.git_diff({ group = true }) end, desc = "Git Diff" },
            { "<leader>gD", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
            { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
            { "<leader>gB", function() Snacks.gitbrowse() end, mode = { "n", "v" }, desc = "Git Browse" },
            {
                "<leader>gM",
                function() Snacks.gitbrowse({ what = "file", branch = "main" }) end,
                mode = { "n", "v" },
                desc = "Git Browse (main)",
            },
            { "<leader>gcc", git_commit, desc = "Git Commit" },
            { "<leader>gca", function() Snacks.terminal("git amend", gitwin) end, desc = "Git Commit Amend" },
            { "<leader>gcA", function() Snacks.terminal("git commit --all", gitwin) end, desc = "Git Commit All" },
            { "<leader>gcz", function() Snacks.terminal("cz commit", gitwin) end, desc = "Git Commit(izen)" },
            { "<leader>gp", function() Snacks.terminal("git add -p") end, desc = "Git Partial Add" },
        },
        opts = {
            picker = {
                sources = {
                    git_log = {
                        confirm = "show_commit",
                    },
                    git_log_line = {
                        confirm = "show_commit",
                    },
                    git_log_file = {
                        confirm = "show_commit",
                    },
                    git_status = {
                        confirm = function(picker)
                            picker:close()
                            git_commit()
                        end,
                    },
                },
                actions = {
                    show_commit = function(_, item)
                        local win_opts = {
                            keys = {
                                -- Go back on left or backspace
                                ["<left>"] = { "cancel", mode = { "n", "x" } },
                                ["<bs>"] = { "cancel", mode = { "n", "x" } },
                                -- Close log and diff on q or esc
                                ["<q>"] = { "close", mode = { "n", "x" } },
                                ["<esc>"] = { "close", mode = { "n", "x" } },
                            },
                        }
                        Snacks.picker.git_diff({
                            group = true,
                            focus = "list",
                            base = item.commit,
                            cmd_args = { item.commit .. "~" },
                            layout = {
                                hidden = { "input" },
                            },
                            win = {
                                list = win_opts,
                                preview = win_opts,
                            },
                        })
                    end,
                },
            },
        },
    },
}
