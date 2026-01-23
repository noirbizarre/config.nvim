return {
    {
        "folke/which-key.nvim",
        opts = {
            spec = {
                { "<leader>d", group = "Debug", icon = " " },
                { "<leader>dp", group = "Debug Printing", icon = " " },
            },
            icons = {
                rules = {
                    { pattern = "print", icon = " " },
                },
            },
        },
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            { "theHamsta/nvim-dap-virtual-text", opts = {} },
            {
                "Joakker/lua-json5",
                lazy = true,
                build = vim.fn.has("win32") == 1 and "powershell ./install.ps1" or "./install.sh",
            },
            {
                "igorlfs/nvim-dap-view",
                -- dev = true,
                opts = {
                    winbar = {
                        sections = { "scopes", "watches", "exceptions", "breakpoints", "threads", "repl" },
                        default_section = "scopes",
                        show_keymap_hints = true,
                        base_sections = {
                            breakpoints = { label = " Breakpoints" },
                            scopes = { label = " Scopes" },
                            exceptions = { label = "󰢃 Exceptions" },
                            watches = { label = "󰛐 Watches" },
                            threads = { label = "󱉯 Threads" },
                            repl = { label = " REPL" },
                            console = { label = " Console" },
                        },
                        controls = {
                            enabled = true,
                            position = "left",
                            buttons = {
                                "play",
                                "step_into",
                                "step_over",
                                "step_out",
                                "term_restart",
                            },
                            custom_buttons = {
                                term_restart = {
                                    render = function()
                                        local session = require("dap").session()
                                        local group = session and "ControlTerminate" or "ControlRunLast"
                                        local icon = session and "" or ""
                                        return "%#NvimDapView" .. group .. "#" .. icon .. "%*"
                                    end,
                                    action = function(clicks, button, modifiers)
                                        local dap = require("dap")
                                        local alt = clicks > 1 or button ~= "l" or modifiers:gsub(" ", "") ~= ""
                                        if not dap.session() then
                                            dap.run_last()
                                        elseif alt then
                                            dap.disconnect()
                                        else
                                            dap.terminate()
                                        end
                                    end,
                                },
                            },
                        },
                    },
                    icons = {
                        play = "",
                        terminate = "",
                    },
                    -- Auto open when a session is started and auto close when all sessions finish
                    -- Alternatively, can be a string:
                    -- - "keep_terminal": as above, but keeps the terminal when the session finishes
                    -- - "open_term": open the terminal when starting a new session, nothing else
                    auto_toggle = "open_term",
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
                "<leader>dP",
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
            dap.listeners.after.event_initialized["dap-view-close-console"] = function(session)
                session.on_close["custom.terminal-autoclose"] = function()
                    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                        local bufname = vim.api.nvim_buf_get_name(buf)
                        if bufname:find("%[dap%-terminal%]") then
                            vim.api.nvim_buf_delete(buf, { force = true })
                        end
                    end
                end
            end

            -- Restore session breakpoints
            vim.api.nvim_create_autocmd("SessionLoadPost", {
                callback = function() require("lib.dap").load_breakpoints() end,
            })
        end,
    },
    -- Debug printing helper
    {
        "ThePrimeagen/refactoring.nvim",
        keys = {
            {
                "<leader>dpp",
                function() require("refactoring").debug.printf({}) end,
                desc = "Print statement",
            },
            {
                "<leader>dpv",
                function() require("refactoring").debug.print_var({}) end,
                mode = { "n", "x" },
                desc = "Print var statement",
            },
            {
                "<leader>dpx",
                function() require("refactoring").debug.cleanup({}) end,
                desc = "Clear print statements",
            },
        },
        opts = {
            printf_statements = {
                python = { 'print(f"🔎 [%s]=> {locals()=}")' },
            },
            print_var_statements = {
                python = { 'print(f"🔎 %.0s{%s=}")' },
            },
        },
    },
}
