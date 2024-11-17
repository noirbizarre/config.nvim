return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
		    "mfussenegger/nvim-dap-python",
            'theHamsta/nvim-dap-virtual-text',
        },
        event = "BufReadPre",
        keys = {
            { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
            { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
            { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
            { "<leader>dl", function() require("dap").set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, desc = "Set Log Point" },
            { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
            { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
            { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
            { "<leader>dj", function() require("dap").down() end, desc = "Down" },
            { "<leader>dk", function() require("dap").up() end, desc = "Up" },
            { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
            { "<leader>dn", function() require("dap").step_over() end, desc = "Step Over" },
            { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
            { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
            { "<leader>ds", function() require("dap").session() end, desc = "Session" },
            { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
            { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
            { "<leader>dR", function() require("dap").clear_breakpoints() end, desc = "Removes all breakpoints" },
            { "<F5>", function() require("dap").continue() end, desc = "Continue" },
            { "<F10>", function() require("dap").step_over() end, desc = "Step over"  },
            { "<F11>", function() require("dap").step_into() end, desc = "Step into"  },
            { "<F12>", function() require("dap").step_out() end, desc = "Step out" },
        },
        config = function()
            require("nvim-dap-virtual-text").setup()

            -- Python adapter settings
			-- uses the debugypy installation by mason
			local debugpyPythonPath = require("mason-registry").get_package("debugpy"):get_install_path() .. "/venv/bin/python3"
			require("dap-python").setup(debugpyPythonPath, {}) ---@diagnostic disable-line: missing-fields
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "mfussenegger/nvim-dap",
        },
        keys = {
			{ "<leader>du", function() require("dapui").toggle({}) end, desc = "Toggle DAP UI" },
			{ "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = { "n", "v" } },
		},
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            dapui.setup()

            -- Better gutter signs
            vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = '', linehl = '', numhl = '' })
            vim.fn.sign_define('DapStopped', { text = '⏩', texthl = '', linehl = '', numhl = '' })
            vim.api.nvim_set_hl(0, "DapStopped", { fg = "#F5A97F" })

            -- Auto toggle DAP UI
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end,
    },
    -- Neotests and plugins
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-neotest/nvim-nio",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "haydenmeade/neotest-jest",
            "nvim-neotest/neotest-go",
            "nvim-neotest/neotest-python",
            "rouge8/neotest-rust",
        },
        ft = {
            "go",
            "javascript",
            "javascript.jsx",
            "javascriptreact",
            "python",
            "rust",
            "typescript",
            "typescript.tsx",
            "typescriptreact",
        },
		keys = {
		    {"<leader>ta", function() require('neotest').run.attach() end, desc = "Neotest: Attach"},
            {"<leader>tf", function() require('neotest').run.run(vim.fn.expand('%')) end, desc = "Neotest: Run File" },
            {"<leader>tF", function() require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'}) end, desc = "Neotest: Debug File" },
            {"<leader>tl", function() require('neotest').run.run_last() end, desc = "Neotest: Run Last" },
            {"<leader>tL", function() require('neotest').run.run_last({ strategy = 'dap' }) end, desc = "Neotest: Debug Last" },
            {"<leader>tn", function() require('neotest').run.run() end, desc = "Neotest: Run Nearest" },
            {"<leader>tN", function() require('neotest').run.run({strategy = 'dap'}) end, desc = "Neotest: Debug Nearest" },
            {"<leader>to", function() require('neotest').output.open({ enter = true }) end, desc = "Neotest: Output" },
            {"<leader>tS", function() require('neotest').run.stop() end, desc = "Neotest: Stop" },
            {"<leader>ts", function() require('neotest').summary.toggle() end, desc = "Neotest: Summary" },
		},
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-python"),
                    require("neotest-jest"),
                    require("neotest-go"),
                    require("neotest-rust"),
                },
            })
        end,
    },
}
