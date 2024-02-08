return {
    "folke/trouble.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    cmd = {
        "Trouble",
        "TroubleClose",
        "TroubleToggle",
        "TroubleRefresh",
    },
    keys = {
        { "<C-x><C-x>", "<cmd>TroubleToggle<cr>", desc = "Trouble" },
    },
    opts = {
        use_diagnostic_signs = true,
    },
}
