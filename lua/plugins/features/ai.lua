local ai = require("lib.ai")

return {
    --- ChatGPT
    --- https://github.com/jackMort/ChatGPT.nvim
    {
        "jackMort/ChatGPT.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        cmd = {
            "ChatGPT",
            "ChatGPTActAs",
            "ChatGPTEditWithInstructions",
        },
        config = function()
            require("chatgpt").setup({
                keymaps = {
                    close = { "<C-c>", "<Esc>" },
                    yank_last = "<C-y>",
                    scroll_up = "<C-u>",
                    scroll_down = "<C-d>",
                    toggle_settings = "<C-o>",
                    new_session = "<C-n>",
                    cycle_windows = "<C-m>",
                },
            })
        end,
    },
    --- Copilot
    --- https://github.com/zbirenbaum/copilot.lua
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        -- config = function()
        --     require("copilot").setup({})
        -- end,
        opts = {},
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
            "CodeCompanionChat",
            "CodeCompanionActions",
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
            { "<leader>aa", ":AvanateAsk<CR>", desc = "Avante" },
            {
                "<leader>ag",
                function()
                    require("avante.api").ask({ question = ai.prompts.grammar_correction() })
                end,
                mode = { "n", "v" },
                desc = "Grammar Correction(ask)",
            },
            {
                "<leader>ak",
                function()
                    require("avante.api").ask({ question = ai.prompts.keywords() })
                end,
                mode = { "n", "v" },
                desc = "Keywords(ask)",
            },
            {
                "<leader>al",
                function()
                    require("avante.api").ask({ question = ai.prompts.code_readability_analysis() })
                end,
                mode = { "n", "v" },
                desc = "Code Readability Analysis(ask)",
            },
            {
                "<leader>ao",
                function()
                    require("avante.api").ask({ question = ai.prompts.optimize_code() })
                end,
                mode = { "n", "v" },
                desc = "Optimize Code(ask)",
            },
            {
                "<leader>am",
                function()
                    require("avante.api").ask({ question = ai.prompts.summarize() })
                end,
                mode = { "n", "v" },
                desc = "Summarize text(ask)",
            },
            {
                "<leader>an",
                function()
                    require("avante.api").ask({ question = ai.prompts.translate() })
                end,
                mode = { "n", "v" },
                desc = "Translate text(ask)",
            },
            {
                "<leader>ax",
                function()
                    require("avante.api").ask({ question = ai.prompts.explain_code() })
                end,
                mode = { "n", "v" },
                desc = "Explain Code(ask)",
            },
            {
                "<leader>ac",
                function()
                    require("avante.api").ask({ question = ai.prompts.complete_code() })
                end,
                mode = { "n", "v" },
                desc = "Complete Code(ask)",
            },
            {
                "<leader>ad",
                function()
                    require("avante.api").ask({ question = ai.prompts.add_docstring() })
                end,
                mode = { "n", "v" },
                desc = "Docstring(ask)",
            },
            {
                "<leader>ab",
                function()
                    require("avante.api").ask({ question = ai.prompts.fix_bugs() })
                end,
                mode = { "n", "v" },
                desc = "Fix Bugs(ask)",
            },
            {
                "<leader>au",
                function()
                    require("avante.api").ask({ question = ai.prompts.add_tests() })
                end,
                mode = { "n", "v" },
                desc = "Add Tests(ask)",
            },
        },
        opts = {
            provider = "copilot",
            auto_suggestions_provider = "copilot",
            claude = {
                -- api_key_name = "cmd:op read op://Personal/Anthropic/tokens/neovim --no-newline",
            },
        },
    },
}
