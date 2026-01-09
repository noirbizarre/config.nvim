local schemas = require("lib.schemas")

vim.filetype.add({
    pattern = {
        -- VSCode JSONC
        [".*/%.vscode/.+%.json"] = "jsonc",
    },
})

local Adapter = schemas.adapter("jsonls", "json/languageStatus")

function Adapter:parse_buf_schemas(result, client)
    local out = {}
    if result and result.schemas then
        for _, schema_url in ipairs(result.schemas) do
            local matched = vim.tbl_filter(
                function(schema) return schema.url == schema_url end,
                ---@diagnostic disable-next-line: undefined-field
                client.config.settings.json.schemas
            )
            for _, schema in ipairs(matched) do
                table.insert(out, {
                    uri = schema.url,
                    name = schema.description,
                    description = schema.description,
                })
            end
        end
    end
    return out
end

return {
    "noirbizarre/ensure.nvim",
    dependencies = {
        "b0o/schemastore.nvim",
    },
    opts = {
        parsers = {
            "jq",
            "json",
            "json5",
            "jsonc",
        },
        linters = {
            json = { "jsonlint" },
        },
        formatters = {
            json = { "prettier" },
            jsonc = { "prettier" },
        },
        lsp = {
            enable = { "jsonls" },
            jsonls = function()
                return {
                    settings = {
                        json = {
                            schemas = require("schemastore").json.schemas(),
                            validate = { enable = true },
                        },
                    },
                }
            end,
        },
    },
}
