return {
    {
        "mfussenegger/nvim-dap",
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
           { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
           { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
           { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
           { "<leader>ds", function() require("dap").session() end, desc = "Session" },
           { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
           { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
           { "<leader>dR", function() require("dap").clear_breakpoints() end, desc = "Removes all breakpoints" },
        },
        config = function()
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "mfussenegger/nvim-dap",
        },
        keys = {
			{ "<leader>du", function() require("dapui").toggle({}) end, desc = "Toggle DAP UI", },
			{ "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = { "n", "v" }, },
		},
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            dapui.setup({})

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
}
