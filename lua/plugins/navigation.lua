return {
    -- {
    --     "noirbizarre/markers.nvim",
    --     dev = true,
    --     keys = {
    --         { "<leader>j", function() require("markers").quickjump() end, desc = "Markers quick jump" },
    --         { "<leader>Bm", function() require("markers").test() end, desc = "Markers test function" },
    --     },
    --     opts = {},
    -- },
    --- Label-based navigation
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            {
                "R",
                mode = { "o", "x" },
                function() require("flash").treesitter_search() end,
                desc = "Treesitter Search",
            },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
    },
    --- Quickfix improvements
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
    --- detect and open links
    {
        "chrishrb/gx.nvim",
        keys = {
            { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } },
        },
        cmd = { "Browse" },
        opts = {
            select_prompt = false,
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
