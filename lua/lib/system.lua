local M = {}

--- Check if the minimum Neovim version is satisfied
--- Expects only the minor version, e.g. "9" for 0.9.1
---@param version number
---@return boolean
M.isNeovimVersionsatisfied = function(version)
    -- Prevent Stylua collapsing
    return version <= tonumber(vim.version().minor)
end

return M
