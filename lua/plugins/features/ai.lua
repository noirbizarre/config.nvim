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
        "craftzdog/solarized-osaka.nvim",
        opts = {
            highlights = {
                SidekickChat = "Normal",
            },
        },
    },
}
