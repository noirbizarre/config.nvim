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

-- MCPHub https://ravitemer.github.io/mcphub.nvim/extensions/lualine.html
local function mcphub()
    -- Check if MCPHub is loaded
    if not vim.g.loaded_mcphub then
        return "󰐻 -"
    end

    local count = vim.g.mcphub_servers_count or 0
    local status = vim.g.mcphub_status or "stopped"
    local executing = vim.g.mcphub_executing

    -- Show "-" when stopped
    if status == "stopped" then
        return "󰐻 -"
    end

    -- Show spinner when executing, starting, or restarting
    if executing or status == "starting" or status == "restarting" then
        local frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        local frame = math.floor(vim.loop.now() / 100) % #frames + 1
        return "󰐻 " .. frames[frame]
    end

    return "󰐻 " .. count
end

local function mcphub_color()
    if not vim.g.loaded_mcphub then
        return { fg = "#6c7086" } -- Gray for not loaded
    end

    local status = vim.g.mcphub_status or "stopped"
    if status == "ready" or status == "restarted" then
        return { fg = "#50fa7b" } -- Green for connected
    elseif status == "starting" or status == "restarting" then
        return { fg = "#ffb86c" } -- Orange for connecting
    else
        return { fg = "#ff5555" } -- Red for error/stopped
    end
end

return {
    options = {
        -- theme = "nightfox",
        -- theme = "solarized_dark",
        section_separators = icons.ui.powerline.separators,
        component_separators = icons.ui.powerline.inner_separators,
        icons_enabled = true,
        always_show_tabline = false,
        globalstatus = true,
        disabled_focus = filetypes.internals,
        disabled_filetypes = {
            statusline = { "snacks_dashboard" },
            winbar = { "gitrebase", table.unpack(filetypes.internals) },
        },
    },
    sections = {
        lualine_a = {
            "mode",
            {
                "macro",
                fmt = function()
                    local reg = vim.fn.reg_recording()
                    if reg ~= "" then
                        return "  @" .. reg
                    end
                    return nil
                end,
                color = { fg = "#b60000", bold = true },
                draw_empty = false,
            },
        },
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
            { mcphub, color = mcphub_color },
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
    tabline = {
        lualine_a = {
            {
                "tabs",
                mode = "tabs",
            },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
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
