vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {"*.tcss"},
    callback = function()
        vim.cmd("set filetype=scss")
        vim.api.nvim_command('set commentstring=/*%s*/')
    end,
})
