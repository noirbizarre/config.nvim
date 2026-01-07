return {
    {
        "folke/which-key.nvim",
        opts = {
            spec = {
                { "<leader>a", group = "AI", icon = "" },
            },
        },
    },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        opts = {
            filetypes = {
                yaml = true,
                markdown = true,
            },
            suggestion = { enabled = false },
            panel = { enabled = false },
        },
    },
    {
        "folke/sidekick.nvim",
        opts = {
            cli = {
                mux = {
                    backend = "tmux",
                    enabled = true,
                    create = "split",
                    split = { size = 0.33 },
                },
            },
        },
        config = function(_, opts)
            require("sidekick").setup(opts)
            if vim.env.__MISE_SESSION then
                --- Use mise if a mise session is detected
                for _, tool in pairs(require("sidekick.config").cli.tools) do
                    tool.cmd = vim.list_extend({ "mise", "exec", "--no-prepare", "--raw", "--" }, tool.cmd)
                end
            end
        end,
        keys = {
            {
                "<tab>",
                function()
                    -- if there is a next edit, jump to it, otherwise apply it if any
                    if not require("sidekick").nes_jump_or_apply() then
                        return "<Tab>" -- fallback to normal tab
                    end
                end,
                expr = true,
                desc = "Goto/Apply Next Edit Suggestion",
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
                function() require("sidekick.cli").send({ msg = "{this}" }) end,
                mode = { "x", "n" },
                desc = "Send This",
            },
            {
                "<leader>af",
                function() require("sidekick.cli").send({ msg = "{file}" }) end,
                desc = "Send File",
            },
            {
                "<leader>ap",
                function() require("sidekick.cli").prompt() end,
                desc = "Sidekick Ask Prompt",
                mode = { "n", "v" },
            },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        opts = function(_, opts)
            -- Copilot status
            table.insert(opts.sections.lualine_x, {
                function() return " " end,
                color = function()
                    local status = require("sidekick.status").get()
                    if status then
                        return status.kind == "Error" and "StatuslineError" or status.busy and "StatuslineWarn" or nil
                    end
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
}
