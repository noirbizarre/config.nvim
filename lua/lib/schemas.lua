local icons = require("lib.ui.icons")

local M = {}

local cache = {}

---@class Schema
---@field uri string The URI of the schema
---@field name? string The display name of the schema
---@field description? string A brief description of the schema

---@class schemas.Adapter
---@field lsp string LSP client name
---@field schema_method string|nil LSP method to request schema
---@field client vim.lsp.Client LSP client
local Adapter = {}

---Parse buffer schemas from LSP result
---@param result table LSP response result
---@param client vim.lsp.Client LSP client
---@return Schema[] schemas Parsed schemas
function Adapter:parse_buf_schemas(result, client) return {} end

---Manually fetch schemas for a given buffer (no dedicated endpoint)
---@param client vim.lsp.Client LSP client
---@param bufnr number Buffer number
---@param callback fun(bufnr:number, schemas:Schema[]) Callback to receive schemas
function Adapter:fetch_buf_schemas(client, bufnr, callback) end

---List available schemas for a given client and buffer
---@param client vim.lsp.Client LSP client
---@param bufnr number Buffer number
---@param callback fun(schemas:Schema[]) Callback to receive schemas
function Adapter:list_schemas(client, bufnr, callback) end

---Set schema buffer
---@param client vim.lsp.Client LSP client
---@param bufnr number Buffer number
---@param uri string Schema URI to set
function Adapter:set_schema(client, bufnr, uri)
    vim.print("Selected schema: ", uri)
    vim.print("Setting schema is not yet supported for " .. self.lsp)
end

---Instantiate a new Adapter
---@param lsp string LSP client name
---@return schemas.Adapter
function Adapter:new(lsp, method)
    local obj = setmetatable({}, { __index = self })
    obj.lsp = lsp
    obj.schema_method = method
    return obj
end

---@type table<string, schemas.Adapter>
M.adapters = {}

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if not client then
            return
        end
        local adapter = M.adapters[client.name]
        if adapter then
            adapter.client = client
            vim.defer_fn(function()
                if adapter.schema_method == nil then
                    adapter:fetch_buf_schemas(client, ev.buf, function(bufnr, schemas) cache[bufnr] = schemas end)
                    return
                else
                    client:request(adapter.schema_method, { vim.uri_from_bufnr(ev.buf) }, function(err, result, ctx)
                        if err then
                            vim.print(adapter.lsp .. " schema error", err)
                            return
                        end
                        cache[ev.buf] = adapter:parse_buf_schemas(result, client)
                    end, ev.buf)
                end
            end, 100)

            local wk = require("which-key")
            wk.add({
                buffer = ev.buf,
                {
                    "<leader>ks",
                    function()
                        adapter:list_schemas(client, ev.buf, function(schemas)
                            schemas = vim.tbl_filter(function(s) return s ~= nil and s.name ~= nil end, schemas)
                            vim.ui.select(schemas, {
                                prompt = "Select Schema:",
                                icon = "󰘦 ",
                                format_item = function(schema) return schema.name end,
                            }, function(choice)
                                if choice == nil then
                                    return
                                end
                                adapter:set_schema(client, ev.buf, choice.uri)
                            end)
                        end)
                    end,
                    desc = "Change Schema",
                },
            })
        end
    end,
})

--- Create a new schema adapter
---@param lsp string LSP client name
---@param method string|nil LSP method to request schema
---@return schemas.Adapter
function M.adapter(lsp, method)
    local adapter = Adapter:new(lsp, method)
    M.adapters[lsp] = adapter
    return adapter
end

--- Get the current schema if any
---@return Schema[]|nil
function M.currents()
    local bufnr = vim.api.nvim_get_current_buf()

    if cache[bufnr] ~= nil then
        return cache[bufnr]
    end
end

--- Get the current schema name if any
---@return string
function M.display_currents()
    local schemas = M.currents()
    if schemas and #schemas > 0 then
        local display_names = {}
        for _, schema in ipairs(schemas) do
            local display = schema.name or schema.description or schema.uri:match("^.+/(.+)$")
            display_names[#display_names + 1] = display:sub(0, 128)
        end
        return table.concat(display_names, " " .. icons.ui.powerline.inner_separators.right .. "󰘦  ")
    end
    return ""
end

function M.select() local bufnr = vim.api.nvim_get_current_buf() end

M.statusline = {
    M.display_currents,
    icon = "󰘦 ",
    draw_empty = false,
}

return M
