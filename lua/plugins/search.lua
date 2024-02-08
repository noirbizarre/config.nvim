return {
    {
        'AckslD/muren.nvim',
        cmd = {
            "MurenToggle",
            "MurenOpen",
            "MurenClose",
            "MurenFresh",
            "MurenUnique",
        },
        keys = {
            {"C-S-f", "<cmd>MurenToggle<cr>", desc = "Search & replace"},
            {"C-S-h", "<cmd>MurenToggle<cr>", desc = "Global search & replace"},
        },
        config = true,
    },
}
