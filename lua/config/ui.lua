local UI = {}

vim.opt.guifont = "FiraCode Nerd Font:h10"

-- Neovide configuration
if vim.g.neovide then
    vim.g.neovide_transparency = 0.9
    -- vim.g.neovide_fullscreen = true
    -- vim.api.nvim_set_hl(0, 'Normal', { bg = "#041D2B" })
end



--- Reusable icons for consistent symbols
UI.icons = {
    diagnostics = {
        Error = " ",
        Warn = " ",
        Hint = " ",
        Info = " ",
    },
    git = {
        added = " ",
        modified = " ",
        removed = " ",
    },
    kinds = {
        Array = " ",
        Boolean = " ",
        Class = " ",
        Color = " ",
        Constant = " ",
        Constructor = " ",
        Enum = " ",
        EnumMember = " ",
        Event = " ",
        Field = " ",
        File = " ",
        Folder = " ",
        Function = " ",
        Interface = " ",
        Key = " ",
        Keyword = " ",
        Method = " ",
        Module = " ",
        Namespace = " ",
        Null = "ﳠ ",
        Number = " ",
        Object = " ",
        Operator = " ",
        Package = " ",
        Property = " ",
        Reference = " ",
        Snippet = " ",
        String = " ",
        Struct = " ",
        Text = " ",
        TypeParameter = " ",
        Unit = " ",
        Value = " ",
        Variable = " ",
    },
    ui = {
        gutter = "▍",
        powerline = {
            separators = { left = "", right = "" },
            inner_separators = { left = "", right = "" },
        }
    },
}


return UI
