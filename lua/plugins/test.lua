local mise = require("lib.mise")

return {
    -- Neotests and plugins
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-neotest/nvim-nio",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        keys = {
            {
                "<leader>ta",
                function() require("neotest").run.attach() end,
                desc = "Neotest: Attach",
            },
            {
                "<leader>tf",
                function() require("neotest").run.run({ vim.fn.expand("%"), env = mise.get_env() }) end,
                desc = "Neotest: Run File",
            },
            {
                "<leader>tt",
                function() require("neotest").run.run({ vim.fn.getcwd(), env = mise.get_env() }) end,
                desc = "Neotest: Run all tests",
            },
            {
                "<leader>tF",
                function() require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap", env = mise.get_env() }) end,
                desc = "Neotest: Debug File",
            },
            {
                "<leader>tl",
                function() require("neotest").run.run_last() end,
                desc = "Neotest: Run Last",
            },
            {
                "<leader>tL",
                function() require("neotest").run.run_last({ strategy = "dap" }) end,
                desc = "Neotest: Debug Last",
            },
            {
                "<leader>tn",
                function() require("neotest").run.run({ env = mise.get_env() }) end,
                desc = "Neotest: Run Nearest",
            },
            {
                "<leader>tN",
                function() require("neotest").run.run({ strategy = "dap", env = mise.get_env() }) end,
                desc = "Neotest: Debug Nearest",
            },
            {
                "<leader>to",
                "<cmd>Neotest output-panel<cr>",
                desc = "Neotest: Output panel",
            },
            {
                "<leader>tO",
                function() require("neotest").output.open({ enter = true }) end,
                desc = "Neotest: Output",
            },
            {
                "<leader>tS",
                function() require("neotest").run.stop() end,
                desc = "Neotest: Stop",
            },
            {
                "<leader>ts",
                function() require("neotest").summary.toggle() end,
                desc = "Neotest: Summary",
            },
            {
                "<leader>twf",
                function() require("neotest").watch.watch({ vim.fn.expand("%"), env = mise.get_env() }) end,
                desc = "Neotest: Watch File",
            },
            {
                "<leader>ww",
                function() require("neotest").watch.watch({ vim.fn.getcwd(), env = mise.get_env() }) end,
                desc = "Neotest: Watch all files",
            },
            {
                "<leader>twn",
                function() require("neotest").watch.watch({ env = mise.get_env() }) end,
                desc = "Neotest: Watch Nearest",
            },
        },
        opts = {
            adapters = {},
        },
    },
}
