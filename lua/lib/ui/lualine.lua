--- Full lualine.nvim configuration
--- See: https://github.com/nvim-lualine/lualine.nvim
local icons = require("lib.ui.icons")

local function get_yaml_schema()
    local schema = require("yaml-companion").get_buf_schema(0)
    if schema.result[1].name == "none" then
        return ""
    end
    return schema.result[1].name
end

return {
    options = {
        -- theme = "nightfox",
        -- theme = "solarized_dark",
        section_separators = icons.ui.powerline.separators,
        component_separators = icons.ui.powerline.inner_separators,
        icons_enabled = true,
        globalstatus = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
            "diff",
            { "diagnostics", sources = { "nvim_diagnostic" } },
            "overseer",
        },
        lualine_x = {
            "searchcount",
            "filetype",
            "fileformat",
            "encoding",
            get_yaml_schema,
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
    },
    extensions = { "quickfix", "toggleterm", "man" },
}
