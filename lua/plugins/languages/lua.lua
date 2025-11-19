local LSPs = {
    "lua_ls",
}

local selene_or_luacheck = function()
    if vim.fs.find({ ".luacheckrc" }, { path = vim.uv.cwd(), upward = true })[1] then
        return "luacheck"
    end
    return "selene"
end

return {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = LSPs,
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            --  Faster LuaLS setup for Neovim
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        opts = function() vim.lsp.enable(LSPs) end,
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "HiPhish/neotest-busted",
        },
        ft = "lua",
        opts = function(_, opts) table.insert(opts.adapters, require("neotest-busted")) end,
    },
    {
        "mfussenegger/nvim-lint",
        opts = {
            linters_by_ft = {
                lua = { selene_or_luacheck() },
            },
        },
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
            },
        },
    },
}
