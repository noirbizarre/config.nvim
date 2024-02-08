return {
    'glepnir/dashboard-nvim',
    cmd = {
        "Dashboard",
        "DashboardNewFile",
        "SessionSave",
        "SessionLoad",
        "SessionDelete",
    },
    event = {
        "VimEnter",
    },
    init = function()
        local db = require("dashboard")
        local static = vim.fn.stdpath("config") .. "/static/"

        -- Heading / Logo
        -- db.preview_command = 'chafa -C true -c 256 --fg-only --symbols braille --clear'
        -- db.preview_command = 'viu --blocks --transparent'
        -- db.preview_command = 'viu --blocks --transparent -w 40 -h 24'
        db.preview_command = 'chafa -c 256 --fg-only --size=40x24'
        db.preview_file_path = static .. "neovim-mark-flat.png"
        db.preview_file_height = 24
        db.preview_file_width = 40

        -- Entries
        db.custom_center = {
            {
                icon = '  ',
                desc = 'Recently latest session                  ',
                shortcut = 'SPC s l',
                action ='SessionLoad'
            },
            {
                icon = '  ',
                desc = 'Recently opened files                   ',
                action =  'DashboardFindHistory',
                shortcut = 'SPC f h'
            },
            {
                icon = '  ',
                desc = 'Find  File                              ',
                action = 'Telescope find_files find_command=rg,--hidden,--files',
                shortcut = 'SPC f f'
            },
            {
                icon = '  ',
                desc ='File Browser                            ',
                action =  'Telescope file_browser',
                shortcut = 'SPC f b'
            },
            {
                icon = '  ',
                desc = 'Find  word                              ',
                action = 'Telescope live_grep',
                shortcut = 'SPC f w'
            },
            -- {
            --     icon = '  ',
            --     desc = 'Open Personal dotfiles                  ',
            --     action = 'Telescope dotfiles path=' .. home ..'/.dotfiles',
            --     shortcut = 'SPC f d'
            -- },
        }
    end,
}
