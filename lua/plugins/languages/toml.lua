-- TODO: Get tombi current schema as soon as support is provided
local schemas = require("lib.schemas")

local Adapter = schemas.adapter("tombi")

function Adapter:fetch_buf_schemas(client, bufnr, callback)
    -- vim.print("Fetching tombi schemas is not yet supported")

    --- textDocument/hover
    ---
    --- textDocument/definition

    -- client:request(
    --     "textDocument/definition",
    --     { textDocument = { uri = vim.uri_from_bufnr(bufnr) }, position = {
    --         line = 0,
    --         character = 0,
    --     } },
    --     function(err, result, ctx)
    --         if err then
    --             vim.print("tombi schema error", err)
    --             return
    --         end
    --         vim.print(result)
    --         local out = {}
    --         callback(bufnr, out)
    --     end,
    --     bufnr
    -- )
end

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if not client or client.name ~= "tombi" then
            return
        end

        vim.api.nvim_create_user_command("TombiRefreshCache", function()
            client:request("tombi/refreshCache", {}, function(err, result)
                if err then
                    vim.print("Tombi refresh cache error: ", err)
                    -- local msg = "Tombi refresh cache error: " .. (err, vim.log.levels.ERROR)
                    -- vim.notify("Tombi refresh cache error: " .. err, vim.log.levels.ERROR)
                    return
                end
                if result then
                    vim.notify("Tombi schema cache refreshed", vim.log.levels.INFO)
                else
                    vim.notify("Tombi schema cache refresh failed", vim.log.levels.ERROR)
                end
            end)
        end, {
            desc = "Refresh tombi schema cache",
        })
    end,
})

return {
    "noirbizarre/ensure.nvim",
    opts = {
        formatters = { toml = "tombi" },
        lsp = {
            enable = { "tombi" },
        },
    },
}
