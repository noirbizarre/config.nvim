local schemas = require("lib.schemas")

vim.filetype.add({
    extension = {
        wiz = "yaml",
    },
})

local Adapter = schemas.adapter("yamlls", "yaml/get/jsonSchema")

function Adapter:parse_buf_schemas(result) return result end

---@class SchemaDefinition
---@field uri string The URL of the schema (accept local path and file:// proto)
---@field name string The name of the schema
---@field description string A brief description of the schema
---@field match string|string[] File name or glob pattern to match files

---@type SchemaDefinition[]
local extra_schemas = {
    {
        uri = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json",
        name = "Argo CD Application",
        description = "Argo CD Application Schema (v1alpha1)",
        match = "argocd-application.yaml",
    },
}

return {
    "noirbizarre/ensure.nvim",
    opts = {
        formatters = {
            yaml = { "prettier" },
        },
        lsp = {
            enable = { "yamlls" },
            yamlls = {
                settings = {
                    yaml = {
                        validate = true,
                        schemas = extra_schemas,
                    },
                },
            },
        },
    },
}
