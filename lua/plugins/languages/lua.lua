local selene_or_luacheck = function()
    if vim.fs.find({ ".luacheckrc" }, { path = vim.uv.cwd(), upward = true })[1] then
        return "luacheck"
    end
    return "selene"
end

return {
    {
        "noirbizarre/ensure.nvim",
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
        opts = {
            linters = {
                lua = { selene_or_luacheck() },
            },
            formatters = {
                lua = { "stylua" },
            },
            lsp = {
                enable = { "lua_ls" },
            },
        },
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "HiPhish/neotest-busted",
            "nvim-neotest/neotest-plenary",
        },
        ft = "lua",
        opts = function(_, opts)
            table.insert(opts.adapters, require("neotest-busted"))
            table.insert(opts.adapters, require("neotest-plenary"))
        end,
    },
}
