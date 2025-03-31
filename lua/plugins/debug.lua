return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "mfussenegger/nvim-dap-python",
            { "theHamsta/nvim-dap-virtual-text", opts = {} },
            {
                "Joakker/lua-json5",
                lazy = true,
                build = vim.fn.has("win32") == 1 and "powershell ./install.ps1" or "./install.sh",
            },
            {
                "igorlfs/nvim-dap-view",
                branch = "feat/scopes",
                opts = {
                    winbar = {
                        sections = { "scopes", "watches", "exceptions", "breakpoints", "threads", "repl" },
                        default_section = "scopes",
                    },
                },
            },
        },
        event = "BufReadPre",
        keys = {
            {
                "<leader>dB",
                function() require("lib.dap").set_conditional_breakpoint() end,
                desc = "Breakpoint Condition",
            },
            {
                "<leader>db",
                function() require("lib.dap").toggle_breakpoint() end,
                desc = "Toggle Breakpoint",
            },
            {
                "<leader>dl",
                function() require("lib.dap").set_log_point() end,
                desc = "Set Log Point",
            },
            {
                "<leader>dC",
                function() require("dap").run_to_cursor() end,
                desc = "Run to Cursor",
            },
            {
                "<leader>dg",
                function() require("dap").goto_() end,
                desc = "Go to line (no execute)",
            },
            {
                "<leader>dj",
                function() require("dap").down() end,
                desc = "Down",
            },
            {
                "<leader>dk",
                function() require("dap").up() end,
                desc = "Up",
            },
            {
                "<leader>dp",
                function() require("dap").pause() end,
                desc = "Pause",
            },
            {
                "<leader>ds",
                function() require("dap").session() end,
                desc = "Session",
            },
            {
                "<leader>dt",
                function() require("dap").terminate() end,
                desc = "Terminate",
            },
            {
                "<leader>dw",
                function() require("dap.ui.widgets").hover() end,
                desc = "Widgets",
            },
            {
                "<leader>dR",
                function() require("lib.dap").clear_breakpoints() end,
                desc = "Removes all breakpoints",
            },
            {
                "<F9>",
                function() require("dap").continue() end,
                desc = "Continue",
            },
            {
                "<F10>",
                function() require("dap").step_over() end,
                desc = "Step over",
            },
            {
                "<F11>",
                function() require("dap").step_into() end,
                desc = "Step into",
            },
            {
                "<F12>",
                function() require("dap").step_out() end,
                desc = "Step out",
            },
            {
                "<leader>dd",
                function() require("dap-view").toggle(true) end,
                desc = "Toggle DAP View",
            },
            {
                "<leader>de",
                function() require("dap-view").add_expr() end,
                desc = "Watch expression",
                mode = { "n", "v" },
            },
        },
        config = function()
            local dap, dv = require("dap"), require("dap-view")

            -- Compat with VSCode JSONC-based launch.json
            require("dap.ext.vscode").json_decode = require("json5").parse

            -- Better gutter signs
            vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939" }) --, bg='#31353f' })
            vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef" }) -- , bg='#31353f' })
            vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379" }) -- , bg='#31353f' })

            vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint", numhl = "DapBreakpoint" })
            vim.fn.sign_define(
                "DapBreakpointCondition",
                { text = "", texthl = "DapBreakpoint", numhl = "DapBreakpoint" }
            )
            vim.fn.sign_define(
                "DapBreakpointRejected",
                { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
            )
            vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint", numhl = "DapLogPoint" })
            vim.fn.sign_define(
                "DapStopped",
                { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
            )

            --- Auto Toggle DAP View
            dap.listeners.before.attach["dap-view-config"] = function() dv.open() end
            dap.listeners.before.launch["dap-view-config"] = function() dv.open() end
            dap.listeners.before.event_terminated["dap-view-config"] = function() dv.close() end
            dap.listeners.before.event_exited["dap-view-config"] = function() dv.close() end

            -- Python adapter settings
            -- uses the debugypy installation by mason
            local debugpy = require("mason-registry").get_package("debugpy")
            local debugpy_python_path = debugpy:get_install_path() .. "/venv/bin/python"
            require("dap-python").setup(debugpy_python_path)

            -- Restore session breakpoints
            vim.api.nvim_create_autocmd("SessionLoadPost", {
                callback = function() require("lib.dap").load_breakpoints() end,
            })
        end,
    },
}
