return {
    --- ChatGPT
    --- https://github.com/jackMort/ChatGPT.nvim
    {
        "jackMort/ChatGPT.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        cmd = {
            "ChatGPT",
            "ChatGPTActAs",
            "ChatGPTEditWithInstructions",
        },
        config = function()
            require("chatgpt").setup({
                keymaps = {
                    close = { "<C-c>", "<Esc>" },
                    yank_last = "<C-y>",
                    scroll_up = "<C-u>",
                    scroll_down = "<C-d>",
                    toggle_settings = "<C-o>",
                    new_session = "<C-n>",
                    cycle_windows = "<C-m>",
                },
            })
        end,
    },

    --- WakaTime time tracking 
    --- https://wakatime.com/
    {
        "wakatime/vim-wakatime",
        lazy = false,
    },
}
