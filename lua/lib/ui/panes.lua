--- Edgy panels definitions
return {
    bottom = {
        -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
        {
            ft = "toggleterm",
            size = { height = 0.4 },
            -- exclude floating windows
            filter = function(buf, win)
                return vim.api.nvim_win_get_config(win).relative == ""
            end,
        },
        {
            ft = "lazyterm",
            title = "LazyTerm",
            size = { height = 0.4 },
            filter = function(buf)
                return not vim.b[buf].lazyterm_cmd
            end,
        },
        {
            ft = "noice",
            size = { height = 0.4 },
            filter = function(buf, win)
                return vim.api.nvim_win_get_config(win).relative == ""
            end,
        },
        "trouble",
        { ft = "qf", title = "QuickFix" },
        {
            ft = "help",
            size = { height = 20 },
            -- only show help buffers
            filter = function(buf)
                return vim.bo[buf].buftype == "help"
            end,
        },
        { title = "Neotest Output", ft = "neotest-output-panel", size = { height = 15 } },
        -- { ft = "spectre_panel", size = { height = 0.4 } },
    },
    left = {
        -- Neo-tree filesystem always takes half the screen height
        {
            title = "Files",
            ft = "neo-tree",
            filter = function(buf)
                return vim.b[buf].neo_tree_source == "filesystem"
            end,
            size = { height = 0.5 },
        },
        {
            title = "Git",
            ft = "neo-tree",
            filter = function(buf)
                return vim.b[buf].neo_tree_source == "git_status"
            end,
            pinned = true,
            collapsed = true, -- show window as closed/collapsed on start
            open = "Neotree position=right git_status",
        },
        {
            title = "Buffers",
            ft = "neo-tree",
            filter = function(buf)
                return vim.b[buf].neo_tree_source == "buffers"
            end,
            pinned = true,
            collapsed = true, -- show window as closed/collapsed on start
            open = "Neotree position=top buffers",
        },
        { title = "Tests", ft = "neotest-summary" },
        -- any other neo-tree windows
        "neo-tree",
    },
    right = {
        { title = "Search & replace", ft = "grug-far", size = { width = 0.25 } },
        { title = "Outline", ft = "sagaoutline", size = { width = 0.18 } },
        { title = "Outline", ft = "Outline", size = { width = 0.18 } },
        { title = "Code Companion", ft = "codecompanion", size = { width = 70 } },
        -- { title = "Avante", ft = "Avante", size = { width = 70 } },
    },
}
