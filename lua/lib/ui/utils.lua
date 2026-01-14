--- Miscelaneous helpers
local M = {}

local ft = require("lib.filetypes")

M.foldexpr = function()
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
end

--- Extend an existing highlight group fron the theme on highlighting
---@param name string Highlight group name
---@param attrs table Attributes to extend
---@return fun(highlights: table, colors: ColorScheme): vim.api.keyset.get_hl_info
function M.extend_hl(name, attrs)
    return function(highlights)
        local hl = highlights[name] or {}
        if type(hl) == "string" then
            hl = { link = hl }
        elseif hl == nil then
            hl = { link = name }
        end
        if hl.link then
            hl = vim.api.nvim_get_hl(0, { name = hl.name, link = false }) or {}
        end
        return vim.tbl_extend("force", hl, attrs)
    end
end

return M
