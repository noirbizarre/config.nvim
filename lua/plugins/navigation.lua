return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "letieu/harpoon-lualine",
        },
        keys = {
            {
                "<leader>hh",
                function()
                    local harpoon = require("harpoon")
                    harpoon.ui:toggle_quick_menu(harpoon:list())
                end,
                desc = "Toggle menu",
            },
            { "<leader>ha", function() require("harpoon"):list():add() end, desc = "Add file" },
            { "<leader>hd", function() require("harpoon"):list():remove() end, desc = "Remove file" },
            { "<leader>hk", function() require("harpoon"):list():next() end, desc = "Next file" },
            {
                "<leader>hj",
                function() require("harpoon"):list():prev() end,
                desc = "Previous file",
            },
            {
                "<leader>h1",
                function() require("harpoon"):list():select(1) end,
                desc = "Go to file 1",
            },
            {
                "<leader>h2",
                function() require("harpoon"):list():select(2) end,
                desc = "Go to file 2",
            },
            {
                "<leader>h3",
                function() require("harpoon"):list():select(3) end,
                desc = "Go to file 3",
            },
            {
                "<leader>h4",
                function() require("harpoon"):list():select(4) end,
                desc = "Go to file 4",
            },
            {
                "<leader>h5",
                function() require("harpoon"):list():select(5) end,
                desc = "Go to file 5",
            },
            --- AZERTY compat' until new laptop
            {
                "<leader>h&",
                function() require("harpoon"):list():select(1) end,
                desc = "Go to file 1",
            },
            {
                "<leader>hé",
                function() require("harpoon"):list():select(2) end,
                desc = "Go to file 2",
            },
            {
                '<leader>h"',
                function() require("harpoon"):list():select(3) end,
                desc = "Go to file 3",
            },
            {
                "<leader>h'",
                function() require("harpoon"):list():select(4) end,
                desc = "Go to file 4",
            },
            {
                "<leader>h(",
                function() require("harpoon"):list():select(5) end,
                desc = "Go to file 5",
            },
        },
        opts = {
            settings = {
                save_on_toggle = true,
                sync_on_ui_close = true,
            },
        },
    },
    --- Quickfix improvements
    --- https://github.com/stevearc/quicker.nvim
    {
        "stevearc/quicker.nvim",
        event = "FileType qf",
        keys = {
            { "<leader>qq", function() require("quicker").toggle() end, desc = "Toggle quickfix" },
        },
        ---@module "quicker"
        ---@type quicker.SetupOptions
        opts = {},
    },
    {
        "swaits/zellij-nav.nvim",
        -- lazy = true,
        event = "VeryLazy",
        keys = {
            { "<M-h>", "<cmd>ZellijNavigateLeftTab<cr>", { silent = true, desc = "Navigate left or tab" } },
            { "<M-j>", "<cmd>ZellijNavigateDown<cr>", { silent = true, desc = "Navigate down" } },
            { "<M-k>", "<cmd>ZellijNavigateUp<cr>", { silent = true, desc = "Navigate up" } },
            { "<M-l>", "<cmd>ZellijNavigateRightTab<cr>", { silent = true, desc = "Navigate right or tab" } },
        },
        opts = {},
    },
    --- detect and open links
    {
        "chrishrb/gx.nvim",
        keys = {
            { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } },
        },
        cmd = { "Browse" },
        opts = {
            handlers = {
                plugin = true,
                github = true,
                package_json = true,
                search = true,
                go = true,
                jira = {
                    name = "jira", -- set name of handler
                    handle = function(mode, line, _)
                        local ticket = require("gx.helper").find(line, mode, "(%u+-%d+)")
                        if ticket and #ticket < 20 then
                            return "https://ledgerhq.atlassian.net/browse/" .. ticket
                        end
                    end,
                },
                rust = {
                    name = "rust",
                    filetype = { "toml" },
                    filename = "Cargo.toml",
                    handle = function(mode, line, _)
                        local crate = require("gx.helper").find(line, mode, "(%w+)%s-=%s")
                        if crate then
                            return "https://crates.io/crates/" .. crate
                        end
                    end,
                },
                pyproject = {
                    name = "pyproject.toml",
                    filetype = { "toml" },
                    filename = "pyproject.toml",
                    handle = function(mode, line, _)
                        local helper = require("gx.helper")
                        local pkg = helper.find(line, mode, '"([%w_%-]+)%s-[<>~=!]=')
                            or helper.find(line, mode, '"([%w_%-]+)%[[%w_%-]+%]%s-[<>~=!]=')
                        if pkg then
                            return "https://pypi.org/project/" .. pkg
                        end
                    end,
                },
                pipfile = {
                    name = "Pipfile",
                    filetype = { "toml" },
                    filename = "Pipfile",
                    handle = function(mode, line, _)
                        local helper = require("gx.helper")
                        local pkg = (
                            helper.find(line, mode, '^([%w_%-]+)%s-=%s-"[<>~=!]=')
                            or helper.find(line, mode, '^([%w_%-]+)%s-=%s-"%*"')
                            or helper.find(line, mode, '^([%w_%-]+)%s-=%s-%{.*version%s-=%s-"[<>~=!]=')
                            or helper.find(line, mode, '^([%w_%-]+)%s-=%s-%{.*version%s-=%s-"%*"')
                        )
                        if pkg then
                            return "https://pypi.org/project/" .. pkg
                        end
                    end,
                },
                requirements = {
                    name = "requirements",
                    filetype = { "requirements" },
                    handle = function(mode, line, _)
                        local helper = require("gx.helper")
                        local pkg = helper.find(line, mode, "([%w_%-]+)%s-[<>~=!]=")
                            or helper.find(line, mode, "([%w_%-]+)%[[%w_%-]+%]%s-[<>~=!]=")
                        if pkg then
                            return "https://pypi.org/project/" .. pkg
                        end
                    end,
                },
                gha = {
                    name = "GitHub Actions",
                    filetype = { "yaml" },
                    handle = function(mode, line, _)
                        local helper = require("gx.helper")
                        local pattern = "([^%s~/@\"']*/[^%s~/@]*)@[^%s~@\"']*"
                        local repo = helper.find(line, mode, pattern)
                        if repo then
                            return "https://github.com/" .. repo
                        end
                    end,
                },
            },
        },
    },
}
