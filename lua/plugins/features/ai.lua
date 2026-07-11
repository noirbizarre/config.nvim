local has_mise = vim.env.__MISE_SESSION and true or false

function with_mise(cmd) return has_mise and { "mise", "exec", "--no-deps", "--raw", "--", cmd } or { cmd } end

return {
    {
        "folke/which-key.nvim",
        opts = {
            spec = {
                { "<leader>a", group = "AI", icon = "" },
                { "<leader>an", group = "Next Edit Suggestions", icon = "⭾" },
            },
        },
    },
    {
        "folke/sidekick.nvim",
        dev = true,
        opts = {
            cli = {
                mux = {
                    backend = "tmux",
                    enabled = true,
                    create = "split",
                    split = { size = 0.33 },
                },
                tools = {
                    opencode = {
                        cmd = with_mise("opencode"),
                    },
                    claude = {
                        cmd = with_mise("claude"),
                    },
                },
            },
        },
        keys = {
            {
                "<tab>",
                function()
                    -- if there is a next edit, jump to it, otherwise apply it if any
                    if require("sidekick").nes_jump_or_apply() then
                        return -- jumped or applied
                    end
                    -- if you are using Neovim's native inline completions
                    if vim.lsp.inline_completion.get() then
                        return
                    end
                    -- fall back to normal tab
                    return "<tab>"
                end,
                mode = { "i", "n" },
                expr = true,
                desc = "Goto/Apply Next Edit Suggestion",
            },
            {
                "<leader>anx",
                function() require("sidekick.nes").clear() end,
                desc = "Clear Next Edit Suggestions",
            },
            {
                "<leader>ant",
                function() require("sidekick.nes").toggle() end,
                desc = "Toggle Next Edit Suggestions",
            },
            {
                "<leader>ann",
                function() require("sidekick.nes").update() end,
                desc = "Request new edits from LSP server (if any)",
            },
            {
                "<c-.>",
                function() require("sidekick.cli").focus() end,
                mode = { "n", "x", "i", "t" },
                desc = "Sidekick Switch Focus",
            },
            {
                "<leader>as",
                function() require("sidekick.cli").select({ filter = { installed = true } }) end,
                desc = "Select CLI",
            },
            {
                "<leader>aa",
                function() require("sidekick.cli").toggle({ focus = true }) end,
                desc = "Sidekick Toggle CLI",
                mode = { "n", "v" },
            },
            {
                "<leader>ao",
                function() require("sidekick.cli").toggle({ name = "opencode", focus = true }) end,
                desc = "OpenCode Toggle",
            },
            {
                "<leader>ac",
                function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end,
                desc = "Claude Code Toggle",
            },
            {
                "<leader>at",
                function() require("sidekick.cli").send({ msg = "{this}", focus = true }) end,
                mode = { "x", "n" },
                desc = "Send This",
            },
            {
                "<leader>af",
                function() require("sidekick.cli").send({ msg = "{file}", focus = true }) end,
                desc = "Send File",
            },
            {
                "<leader>ap",
                function() require("sidekick.cli").prompt() end,
                desc = "Sidekick Ask Prompt",
                mode = { "n", "x" },
            },
        },
    },
    {
        "saghen/blink.cmp",
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        ---@diagnostic disable: missing-fields
        opts = {
            keymap = {
                --- Amend super-tab preset with Next Edit Suggestion
                ["<Tab>"] = {
                    function(cmp)
                        if cmp.snippet_active() then
                            return cmp.accept()
                        else
                            return cmp.select_and_accept()
                        end
                    end,
                    "snippet_forward",
                    function() -- sidekick next edit suggestion
                        return require("sidekick").nes_jump_or_apply()
                    end,
                    function() -- if you are using Neovim's native inline completions
                        return vim.lsp.inline_completion.get()
                    end,
                    -- Will be available in Neovim 0.12+
                    -- function() -- if you are using Neovim's native inline completions
                    --     return vim.lsp.inline_completion.get()
                    -- end,
                    "fallback",
                },
            },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        opts = function(_, opts)
            -- Copilot status
            table.insert(opts.sections.lualine_x, {
                function()
                    local status = require("sidekick.status").get()
                    if status and (status.kind == "Inactive" or status.kind == "Error") then
                        return " "
                    elseif status and status.kind == "Warning" then
                        return " "
                    end
                    return " "
                end,
                color = function()
                    local status = require("sidekick.status").get()
                    if status and status.kind == "Error" then
                        return "StatuslineError"
                    elseif status and status.busy then
                        return "StatuslineWarn"
                    end
                    return ""
                end,
                cond = function() return require("sidekick.status").get() ~= nil end,
            })
            -- CLI session status
            table.insert(opts.sections.lualine_x, {
                function()
                    local status = require("sidekick.status").cli()
                    return " " .. (#status > 1 and #status or "")
                end,
                cond = function() return #require("sidekick.status").cli() > 0 end,
            })
        end,
    },
    {
        "craftzdog/solarized-osaka.nvim",
        opts = {
            highlights = {
                SidekickChat = "Normal",
            },
        },
    },
    {
        "noirbizarre/ensure.nvim",
        opts = {
            lsp = {
                enable = { "copilot" },
            },
        },
    },
}
