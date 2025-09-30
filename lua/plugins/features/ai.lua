local ai = require("lib.ai")

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
    --- CodeCompanion
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
            "AvanteClear",
            "AvanteEdit",
            "AvanteFocus",
            "AvanteModels",
            "AvanteRefresh",
            "AvanteSwitchProvider",
            "AvanteToggle",
        },
        --- https://github.com/yetone/avante.nvim/wiki/Recipe-and-Tricks#advanced-shortcuts-for-frequently-used-queries-756
        keys = {
            { "<leader>aa", ":AvanteAsk<CR>", desc = "Toggle Avante" },
            { "<leader>am", ":AvanteModels<CR>", desc = "Choose Avante model" },
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
            providers = {
                copilot = {
                    model = "gpt-4.1",
                    -- model = "claude-3.7-sonnet",
                },
                -- ["copilot/claude-3.5"] = {
                --     __inherited_from = "copilot",
                --     model = "claude-3.5-sonnet",
                --     display_name = "copilot/claude-3.5",
                --     max_tokens = 65536,
                --     -- disable_tools = true,
                -- },
                -- ["copilot/claude-3.7"] = {
                --     __inherited_from = "copilot",
                --     model = "claude-3.7",
                --     display_name = "copilot/claude-3.7",
                --     max_tokens = 65536,
                --     -- disable_tools = true,
                -- },
                ["copilot/claude-3.7-thought"] = {
                    __inherited_from = "copilot",
                    model = "claude-3.7-sonnet-thought",
                    display_name = "copilot/claude-3.7-thought",
                    extra_request_body = { max_tokens = 65536 },
                    -- disable_tools = true,
                },
                ["copilot/o1"] = {
                    __inherited_from = "copilot",
                    model = "o1",
                    display_name = "copilot/o1",
                    extra_request_body = { max_tokens = 100000 },
                    -- disable_tools = true,
                },
                ["copilot/o1-mini"] = {
                    __inherited_from = "copilot",
                    model = "o1-mini",
                    display_name = "copilot/o1-mini",
                    extra_request_body = { max_tokens = 100000 },
                    -- disable_tools = true,
                },
                ["copilot/o3-mini"] = {
                    __inherited_from = "copilot",
                    model = "o3-mini",
                    display_name = "copilot/o3-mini",
                    extra_request_body = { max_tokens = 100000 },
                    -- disable_tools = true,
                },
                ["copilot/o4-mini"] = {
                    __inherited_from = "copilot",
                    model = "o4-mini",
                    display_name = "copilot/o4-mini",
                    extra_request_body = { max_tokens = 100000 },
                    -- disable_tools = true,
                },
                ["copilot/gpt-4.1"] = {
                    __inherited_from = "copilot",
                    model = "gpt-4.1",
                    display_name = "copilot/gpt-4.1",
                    extra_request_body = { max_tokens = 128000 },
                    -- disable_tools = true,
                },
                ["copilot/gemini-2.0"] = {
                    __inherited_from = "copilot",
                    model = "gemini-2.0-flash-001",
                    display_name = "copilot/gemini-2.0-flash",
                    extra_request_body = { max_tokens = 8192 },
                    -- disable_tools = true,
                },
                ["copilot/gemini-2.5"] = {
                    __inherited_from = "copilot",
                    model = "gemini-2.5-pro",
                    display_name = "copilot/gemini-2.5-pro",
                    extra_request_body = { max_tokens = 65536 },
                    -- disable_tools = true,
                },
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
}
