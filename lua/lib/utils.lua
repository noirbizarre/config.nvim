local M = {}

--- Set merged config on a `vim.g` namespace while benefiting from opts merging
--- For plugins following https://mrcjkb.dev/posts/2023-08-22-setup.html
---@param namespace string The vim.g namespace to set
---@return fun(_, opts: table): nil function A function that sets the config
function M.gconf(namespace)
    local config = function(_, opts)
        -- Set the vim.g namespace config
        vim.g[namespace] = vim.tbl_deep_extend("force", vim.g[namespace] or {}, opts or {})
    end
    return config
end

return M
