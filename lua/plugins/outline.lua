return {
    "simrat39/symbols-outline.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    cmd = {
        "SymbolsOutline",
        "SymbolsOutlineOpen",
        "SymbolsOutlineClose",
    },
    keys = {
        { "<C-p>", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" },
    },
    config = true,
    -- config = function()
    --   require("symbols-outline").setup {
    --     -- your configuration comes here
    --     -- or leave it empty to use the default settings
    --     -- refer to the configuration section below
    --   }
    -- end,
}
