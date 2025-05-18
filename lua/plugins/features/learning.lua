return {
    {
        "m4xshen/hardtime.nvim",
        lazy = false,
        dependencies = { "MunifTanjim/nui.nvim" },
        cmd = { "Hardtime" },
        keys = {
            { "<leader>uh", "<cmd>Hardtime toggle<cr>", desc = "Toggle hardtime" },
        },
        opts = {
            enabled = false,
        },
    },
}
