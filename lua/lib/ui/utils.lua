--- Miscelaneous helpers
local ft = require("lib.filetypes")

return {
    foldexpr = function()
        local buf = vim.api.nvim_get_current_buf()
        if vim.b[buf].ts_folds == nil then
            -- as long as we don't have a filetype, don't bother
            -- checking if treesitter is available (it won't)
            if vim.bo[buf].filetype == "" then
                return "0"
            end
            if ft.internals[vim.bo[buf].filetype] ~= nil then
                vim.b[buf].ts_folds = false
            else
                vim.b[buf].ts_folds = pcall(vim.treesitter.get_parser, buf)
            end
        end
        return vim.b[buf].ts_folds and vim.treesitter.foldexpr() or "0"
    end,
}
