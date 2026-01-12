return {
    {
        "folke/which-key.nvim",
        opts = {
            spec = {
                {
                    group = "Session",
                    icon = "󰁯",
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
            },
        },
    },
    -- Measure startuptime
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
        config = function() vim.g.startuptime_tries = 10 end,
    },

    --- Session persistence
    {
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        keys = {
            { "<leader>S", function() require("persistence").save() end, desc = "Save session" },
        },
        config = function()
            local persistence = require("persistence")
            persistence.setup({})
            local is_loading = false
            local group = vim.api.nvim_create_augroup("user-persistence", { clear = true })

            vim.api.nvim_create_autocmd("User", {
                group = group,
                pattern = "PersistenceLoadPre",
                callback = function() is_loading = true end,
            })
            vim.api.nvim_create_autocmd("User", {
                group = group,
                pattern = "PersistenceLoadPost",
                callback = function() is_loading = false end,
            })
            vim.api.nvim_create_autocmd({ "BufWritePost", "BufDelete", "BufAdd" }, {
                group = vim.api.nvim_create_augroup("persistence_auto_save", { clear = true }),
                callback = function()
                    if persistence.active() and not is_loading then
                        persistence.save()
                    end
                end,
            })
        end,
    },

    --- Privileges escalation
    {
        "lambdalisue/suda.vim",
        lazy = false,
        init = function() vim.g["suda_smart_edit"] = 1 end,
    },
}
