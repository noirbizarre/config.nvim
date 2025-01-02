return {
    -- Measure startuptime
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
        config = function() vim.g.startuptime_tries = 10 end,
    },

    --- Session persistence
    --- https://github.com/folke/persistence.nvim
    {
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        opts = {
            -- add any custom options here
        },
    },

    --- Privileges escalation
    {
        "lambdalisue/suda.vim",
        lazy = false,
        init = function() vim.g["suda_smart_edit"] = 1 end,
    },
}
