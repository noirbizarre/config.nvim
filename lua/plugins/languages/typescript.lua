local biome_or_prettier = function()
    if vim.fs.find({ "biome.json", "biome.jsonc" }, { path = vim.uv.cwd(), upward = true })[1] then
        return "biome"
    end
    return "prettier"
end
local formatter = biome_or_prettier()

return {
    {
        "noirbizarre/ensure.nvim",
        opts = {
            formatters = {
                javascript = { formatter },
                javascriptreact = { formatter },
                typescript = { formatter },
                typescriptreact = { formatter },
            },
            lsp = {
                enable = { "tsgo", "biome" },
            },
        },
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "haydenmeade/neotest-jest",
        },
        ft = {
            "javascript",
            "javascript.jsx",
            "javascriptreact",
            "typescript",
            "typescript.tsx",
            "typescriptreact",
        },
        opts = function(_, opts) table.insert(opts.adapters, require("neotest-jest")) end,
    },
}
