local LSPs = {
    "sqlls",
}

return {
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
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = LSPs,
        },
    },
    {
        "neovim/nvim-lspconfig",
        opts = function() vim.lsp.enable(LSPs) end,
    },
    {
        "mfussenegger/nvim-lint",
        opts = {
            linters_by_ft = {
                sql = { "sqlfluff" },
            },
        },
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                sql = { "sqlfluff" },
            },
        },
    },
}
