return {
    --- Interactive DB client
    {
        "kndndrj/nvim-dbee",
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
            return {
                sources = {
                    sources.EnvSource:new("DBEE_CONNECTIONS"),
                    sources.FileSource:new(vim.uv.cwd() .. "/.nvim/dbee.json"),
                },
            }
        end,
    },
}
