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
            "CopilotChatPrompts",
        },
        keys = {
            { "<leader>ii", "<cmd>CopilotChatToggle<cr>", desc = "Toggle Copilot Chat" },
            { "<leader>im", "<cmd>CopilotChatModels<cr>", desc = "Copilot Chat Models" },
            { "<leader>ia", "<cmd>CopilotChatAgents<cr>", desc = "Copilot Chat Agents" },
            { "<leader>ik", "<cmd>CopilotChatPrompts<cr>", desc = "Copilot Chat Prompts" },
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
        },
        opts = {
            display = {
                action_palette = {
                    provider = "default",
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
                tools = {
                    ["mcp"] = {
                        -- Prevent mcphub from loading before needed
                        callback = function() return require("mcphub.extensions.codecompanion") end,
                        description = "Call tools and resources from the MCP Servers",
                        opts = {
                            requires_approval = true,
                        },
                    },
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
            { "<leader>aa", ":AvanteAsk<CR>", desc = "Toggle Avante" },
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
                model = "claude-3.7-sonnet",
            },
            file_selector = {
                provider = "snacks",
            },
            system_prompt = function()
                local hub = require("mcphub").get_hub_instance()
                return hub:get_active_servers_prompt()
            end,
            -- The custom_tools type supports both a list and a function that returns a list. Using a function here prevents requiring mcphub before it's loaded
            custom_tools = function()
                return {
                    require("mcphub.extensions.avante").mcp_tool(),
                }
            end,
            disabled_tools = {
                "list_files",
                "search_files",
                "read_file",
                "create_file",
                "rename_file",
                "delete_file",
                "create_dir",
                "rename_dir",
                "delete_dir",
                "bash",
            },
        },
    },
    --- MCP support
    {
        "ravitemer/mcphub.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
        },
        -- comment the following line to ensure hub will be ready at the earliest
        cmd = "MCPHub", -- lazy load by default
        -- build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
        -- uncomment this if you don't want mcp-hub to be available globally or can't use -g
        build = "bundled_build.lua", -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
        opts = {
            config = os.getenv("MCP_SERVERS_CONF") or (vim.fn.stdpath("config") .. "/data/mcphub.json"),
            use_bundled_binary = true,
            extensions = {
                avante = {},
                codecompanion = {},
            },
            -- Logging configuration
            log = {
                level = vim.log.levels.INFO,
                to_file = true,
                file_path = vim.fn.stdpath("state") .. "/mcphub.log",
                -- prefix = "MCPHub",
            },
        },
    },
}
