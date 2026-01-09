local bufnr = vim.api.nvim_get_current_buf()
local winid = vim.api.nvim_get_current_win()
local wk = require("which-key")

wk.add({
    buffer = bufnr,
    group = "Git Blame",
    {
        "q",
        function() vim.api.nvim_win_close(winid, true) end,
        desc = "Close Blame window",
        icon = " ",
    },
})
