return {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended
    lazy = false, -- This plugin is already lazy
    config = function()
        ---@type rustaceanvim.Opts
        vim.g.rustaceanvim = {
            tools = {
                code_actions = {
                    ui_select_fallback = true,
                },
                float_win_config = {
                    auto_focus = true,
                },
            },
        }
    end,
}
