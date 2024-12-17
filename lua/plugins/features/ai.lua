local ai = require("lib.ai")

return {
    --- Copilot
    --- https://github.com/zbirenbaum/copilot.lua
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
    --- CopilotChat
    --- https://github.com/CopilotC-Nvim/CopilotChat.nvim
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "zbirenbaum/copilot.lua" },
            { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
        },
        build = "make tiktoken", -- Only on MacOS or Linux
        cmd = {
            "CopilotChat",
            "CopilotChatOpen",
            "CopilotChatClose",
            "CopilotChatToggle",
            "CopilotChatStop",
            "CopilotChatReset",
            "CopilotChatSave",
            "CopilotChatLoad",
            "CopilotChatDebugInfo",
            "CopilotChatModels",
            "CopilotChatAgents",
        },
        keys = {
            { "<leader>ii", "<cmd>CopilotChatToggle<cr>", desc = "Toggle Copilot Chat" },
            { "<leader>im", "<cmd>CopilotChatModels<cr>", desc = "Copilot Chat Models" },
            { "<leader>ia", "<cmd>CopilotChatAgents<cr>", desc = "Copilot Chat Agents" },
        },
        opts = {
            -- See Configuration section for options
        },
        -- See Commands section for default commands if you want to lazy load on them
    },
    --- CodeCompanion
    --- https://github.com/olimorris/codecompanion.nvim
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-telescope/telescope.nvim", -- Optional: For using slash commands
            "OXY2DEV/markview.nvim",
            -- { "stevearc/dressing.nvim", opts = {} }, -- Optional: Improves `vim.ui.select`
            --- For copilot provider
            "zbirenbaum/copilot.lua",
        },
        cmd = {
            "CodeCompanion",
            "CodeCompanionActions",
            "CodeCompanionChat",
            "CodeCompanionCmd",
        },
        keys = {
            { "<leader>cp", ":CodeCompanion ", mode = { "n", "v" }, desc = "Code Companion prompt" },
            { "<leader>cc", ":CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Code Companion chat" },
            { "<leader>ca", ":CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "Code Companion actions" },
            { "<leader>cA", ":CodeCompanionChat Add<cr>", mode = { "v" }, desc = "Code Companion add to chat" },
            -- { "<leader>kc", ":Telescope codecompanion<cr>", mode = { 'n', 'v' }, desc = "Code Companion action (telescope)"},
        },
        opts = {
            display = {
                action_palette = {
                    provider = "telescope",
                },
                chat = {
                    render_headers = false,
                },
            },
            strategies = {
                chat = {
                    adapter = "copilot",
                },
                inline = {
                    adapter = "copilot",
                },
            },
        },
    },
    --- Avante Cursor AI like IDE
    --- https://github.com/yetone/avante.nvim
    {
        "yetone/avante.nvim",
        build = "make",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
            "OXY2DEV/markview.nvim",
            --- For copilot provider
            "zbirenbaum/copilot.lua",
        },
        cmd = {
            "AvanteAsk",
            "AvanteChat",
            "AvanteEdit",
            "AvanteToggle",
            "AvanteClear",
            "AvanteFocus",
            "AvanteRefresh",
            "AvanteSwitchProvider",
        },
        --- https://github.com/yetone/avante.nvim/wiki/Recipe-and-Tricks#advanced-shortcuts-for-frequently-used-queries-756
        keys = {
            -- { "<leader>aa", ":AvanteAsk<CR>", desc = "Toggle Avante" },
            { "<leader>a<BS>", ":AvanteClear<CR>", desc = "Clear Avante" },
            -- Custom prompts
            {
                "<leader>apg",
                function() require("avante.api").ask({ question = ai.prompts.grammar_correction() }) end,
                mode = { "n", "v" },
                desc = "Grammar Correction",
            },
            {
                "<leader>apk",
                function() require("avante.api").ask({ question = ai.prompts.keywords() }) end,
                mode = { "n", "v" },
                desc = "Keywords",
            },
            {
                "<leader>apl",
                function() require("avante.api").ask({ question = ai.prompts.code_readability_analysis() }) end,
                mode = { "n", "v" },
                desc = "Code Readability Analysis",
            },
            {
                "<leader>apo",
                function() require("avante.api").ask({ question = ai.prompts.optimize_code() }) end,
                mode = { "n", "v" },
                desc = "Optimize Code",
            },
            {
                "<leader>aps",
                function() require("avante.api").ask({ question = ai.prompts.summarize() }) end,
                mode = { "n", "v" },
                desc = "Summarize text",
            },
            {
                "<leader>api",
                function() require("avante.api").ask({ question = ai.prompts.translate() }) end,
                mode = { "n", "v" },
                desc = "Translate text",
            },
            {
                "<leader>apx",
                function() require("avante.api").ask({ question = ai.prompts.explain_code() }) end,
                mode = { "n", "v" },
                desc = "Explain Code",
            },
            {
                "<leader>apc",
                function() require("avante.api").ask({ question = ai.prompts.complete_code() }) end,
                mode = { "n", "v" },
                desc = "Complete Code",
            },
            {
                "<leader>apd",
                function() require("avante.api").ask({ question = ai.prompts.add_docstring() }) end,
                mode = { "n", "v" },
                desc = "Docstring",
            },
            {
                "<leader>apf",
                function() require("avante.api").ask({ question = ai.prompts.fix_bugs() }) end,
                mode = { "n", "v" },
                desc = "Fix Bugs",
            },
            {
                "<leader>apt",
                function() require("avante.api").ask({ question = ai.prompts.add_tests() }) end,
                mode = { "n", "v" },
                desc = "Add Tests",
            },
        },
        opts = {
            provider = "copilot",
            auto_suggestions_provider = "copilot",
            copilot = {
                model = "claude-3.5-sonnet",
            },
        },
    },
}
