--- Full lualine.nvim configuration
--- See: https://github.com/nvim-lualine/lualine.nvim
local icons = require("lib.ui.icons")
local filetypes = require("lib.filetypes")
table.unpack = table.unpack or unpack -- 5.1 compatibility

local function get_yaml_schema()
    local schema = require("yaml-companion").get_buf_schema(0)
    if schema.result[1].name == "none" then
        return ""
    end
    return schema.result[1].name
end

local function dirs()
    local utils = require("lualine.utils.utils")
    local filename = vim.fn.expand("%:~:.")
    local parts = {}
    for part in string.gmatch(filename, "[^/]+") do
        table.insert(parts, part)
    end
    table.remove(parts)
    return utils.stl_escape(table.concat(parts, " " .. icons.ui.powerline.inner_separators.left .. " "))
end

local function modified()
    if vim.bo.modified then
        return icons.file_status.modified
    elseif vim.bo.modifiable == false or vim.bo.readonly == true then
        return icons.file_status.readonly
    end
    return ""
end

return {
    options = {
        -- theme = "nightfox",
        -- theme = "solarized_dark",
        section_separators = icons.ui.powerline.separators,
        component_separators = icons.ui.powerline.inner_separators,
        icons_enabled = true,
        globalstatus = true,
        disabled_focus = filetypes.internals,
        disabled_filetypes = {
            statusline = { "snacks_dashboard" },
            winbar = { "gitrebase", table.unpack(filetypes.internals) },
        },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = {
            {
                "branch",
                on_click = function() Snacks.picker.git_branches() end,
            },
        },
        lualine_c = {
            {
                "diff",
                on_click = function() Snacks.picker.git_diff() end,
            },
            {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                on_click = function() Snacks.picker.diagnostics() end,
            },
            "overseer",
        },
        lualine_x = {
            "searchcount",
            "filetype",
            "fileformat",
            "encoding",
            get_yaml_schema,
            {
                "copilot",
                show_colors = true,
                on_click = function() vim.cmd("Copilot toggle") end,
            },
        },
        lualine_y = { "progress" },
        lualine_z = { "location", { "harpoon2", no_harpoon = "" } },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
    },
    winbar = {
        lualine_a = {
            {
                dirs,
                on_click = function() Snacks.picker.files() end,
            },
        },
        lualine_b = {
            { "filetype", colored = true, icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            {
                "filename",
                on_click = function()
                    local dir = vim.fn.expand("%:h")
                    Snacks.picker.files({ dirs = { dir } })
                end,
                color = { gui = "bold" },
                padding = { left = 0, right = 1 },
                file_status = false,
                separator = "",
            },
            {
                modified,
                on_click = function() Snacks.picker.files() end,
                draw_empty = true,
                padding = { left = 0, right = 1 },
                color = { fg = "orange" },
            },
        },
        lualine_c = {
            {
                "navic",
                on_click = function() Snacks.picker.lsp_symbols() end,
                color_correction = "dynamic",
            },
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },

    inactive_winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
            {
                dirs,
                on_click = function() Snacks.picker.files() end,
            },
            { "filetype", colored = true, icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            {
                "filename",
                on_click = function() Snacks.picker.files() end,
                padding = { left = 0, right = 1 },
                file_status = false,
                separator = "",
            },
            {
                modified,
                on_click = function() Snacks.picker.files() end,
                draw_empty = true,
                padding = { left = 0, right = 1 },
                color = { fg = "orange" },
            },
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    extensions = { "quickfix", "toggleterm", "man" },
}
