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
    },
    -- Git integration for buffers
    -- https://github.com/lewis6991/gitsigns.nvim
    {
        "lewis6991/gitsigns.nvim",
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {
            
        },
    },
    --- https://github.com/NeogitOrg/neogit
    {
        "NeogitOrg/neogit",
        cmd = "Neogit",
        keys = {
            { "<leader>gp", "<cmd>Neogit <cr>", mode = { "n", "v" }, desc = "Neogit" },
            {
                "<leader>gl",
                function()
                    require("neogit").action("log", "log_current", {"--graph"})()
                end,
                mode = { "n", "v" },
                desc = "Neogit logs",
            },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "sindrets/diffview.nvim",        -- optional - Diff integration
            "nvim-telescope/telescope.nvim", -- optional
        },
        opts = {
            kind = "vsplit",
            -- graph_style = "unicode",
            graph_style = "kitty",
            section = { "", "" },
            item = { "", "" },
            hunk = { "", "" },
            -- log_view = {
            --     kind = "vsplit",
            -- },
            integrations = {
                diffview = true,
                telescope = true,
            },
        }
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
        -- config = function()
        --     require("octo").setup()
        -- end,
    },
}
