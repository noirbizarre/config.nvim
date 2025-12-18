return {
    {
        "noirbizare/ensure.nvim",
        opts = {
            linters = {
                sql = { "sqlfluff" },
            },
            formatters = {
                sql = { "sqlfluff" },
            },
            lsp = {
                enable = { "sqlls" },
            },
        },
    },
    --- Interactive DB client
    {
        "kndndrj/nvim-dbee",
        branch = "master",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        keys = {
            { "<leader>DD", function() require("dbee").toggle() end, desc = "Toggle DBee" },
            { "<leader>DB", function() require("dbee").toggle() end, desc = "Toggle DBee" },
        },
        build = function()
            -- Install tries to automatically detect the install method.
            -- if it fails, try calling it with one of these parameters:
            --    "curl", "wget", "bitsadmin", "go"
            require("dbee").install()
        end,
        opts = function()
            local sources = require("dbee.sources")
            local providers = {
                sources.EnvSource:new("DBEE_CONNECTIONS"),
            }
            local local_config = vim.uv.cwd() .. "/.nvim/dbee.json"
            if vim.uv.fs_stat(local_config) then
                table.insert(providers, sources.FileSource:new(local_config))
            end
            if vim.env.DBEE_JSON ~= nil then
                table.insert(providers, sources.FileSource:new(vim.env.DBEE_JSON))
            end

            return {
                sources = providers,
            }
        end,
    },
    -- {
    --     "xemptuous/sqlua.nvim",
    --     lazy = true,
    --     cmd = {"SQLua", "SQLuaEdit"},
    --     opts = {},
    -- },
}
