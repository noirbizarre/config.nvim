local ft = require("lib.filetypes")

local function group(name)
    -- Prevent Stylua collapse
    return vim.api.nvim_create_augroup(name, { clear = true })
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.tcss" },
    callback = function()
        vim.cmd("set filetype=scss")
        vim.api.nvim_command("set commentstring=/*%s*/")
    end,
})

-- Disable statuscolumn on internal windows
vim.api.nvim_create_autocmd("BufEnter", {
    group = group("no_statuscolumn"),
    callback = function()
        if vim.tbl_contains(ft.internals, vim.bo.filetype) then
            vim.wo.statuscolumn = ""
        end
    end,
})
