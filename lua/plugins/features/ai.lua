return {
    --- Copilot
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
        "NickvanDyke/opencode.nvim",
        dependencies = {
            -- Recommended for better prompt input, and required to use opencode.nvim's embedded terminal — otherwise optional
            { "folke/snacks.nvim", opts = { input = { enabled = true } } },
        },
        ---@type opencode.Opts
        opts = {
            -- Your configuration, if any — see lua/opencode/config.lua
        },
        keys = {
            -- Recommended keymaps
            { "<leader>oA", function() require("opencode").ask() end, desc = "Ask opencode" },
            {
                "<leader>oa",
                function() require("opencode").ask("@cursor: ") end,
                desc = "Ask opencode about this",
                mode = "n",
            },
            {
                "<leader>oa",
                function() require("opencode").ask("@selection: ") end,
                desc = "Ask opencode about selection",
                mode = "v",
            },
            {
                "<leader>ob",
                function() require("opencode").ask("@buffer: ") end,
                desc = "Ask opencode about @buffer",
                mode = "n",
            },
            { "<leader>ot", function() require("opencode").toggle() end, desc = "Toggle embedded opencode" },
            { "<leader>on", function() require("opencode").command("session_new") end, desc = "New session" },
            { "<leader>oy", function() require("opencode").command("messages_copy") end, desc = "Copy last message" },
            {
                "<S-C-u>",
                function() require("opencode").command("messages_half_page_up") end,
                desc = "Scroll messages up",
            },
            {
                "<S-C-d>",
                function() require("opencode").command("messages_half_page_down") end,
                desc = "Scroll messages down",
            },
            {
                "<leader>op",
                function() require("opencode").select_prompt() end,
                desc = "Select prompt",
                mode = { "n", "v" },
            },
            {
                "<leader>oe",
                function() require("opencode").prompt("Explain @cursor and its context") end,
                desc = "Explain code near cursor",
            },

            {
                "<leader>o+",
                function() require("opencode").prompt("@buffer", { append = true }) end,
                desc = "Add buffer to prompt",
            },
            {
                "<leader>o+",
                function() require("opencode").prompt("@selection", { append = true }) end,
                mode = { "v" },
                desc = "Add selection to prompt",
            },
        },
    },
    {
        "folke/sidekick.nvim",
        opts = {
            -- add any options here
            cli = {
                mux = {
                    backend = "tmux",
                    enabled = true,
                },
            },
        },
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
                "<leader>aa",
                function() require("sidekick.cli").toggle({ focus = true }) end,
                desc = "Sidekick Toggle CLI",
                mode = { "n", "v" },
            },
            {
                "<leader>ao",
                function() require("sidekick.cli").toggle({ name = "opencode", focus = true }) end,
                desc = "OpenCode Toggle",
                mode = { "n", "v" },
            },
            {
                "<leader>ap",
                function() require("sidekick.cli").select_prompt() end,
                desc = "Sidekick Ask Prompt",
                mode = { "n", "v" },
            },
        },
    },
}
