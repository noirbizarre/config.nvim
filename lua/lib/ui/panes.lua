--- Edgy panels definitions
local opts = {
    bottom = {
        -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
        {
            ft = "toggleterm",
            size = { height = 0.4 },
            -- exclude floating windows
            filter = function(buf, win) return vim.api.nvim_win_get_config(win).relative == "" end,
        },
        {
            ft = "lazyterm",
            title = "LazyTerm",
            size = { height = 0.4 },
            filter = function(buf) return not vim.b[buf].lazyterm_cmd end,
        },
        {
            ft = "snacks_terminal",
            size = { height = 0.4 },
            title = "Terminal #%{b:snacks_terminal.id}",
            -- title = "%{b:snacks_terminal.id}: %{b:term_title}",
            filter = function(_buf, win)
                return vim.w[win].snacks_win
                    and vim.w[win].snacks_win.position == "bottom"
                    and vim.w[win].snacks_win.relative == "editor"
                    and not vim.w[win].trouble_preview
            end,
        },
        {
            ft = "noice",
            size = { height = 0.4 },
            filter = function(buf, win) return vim.api.nvim_win_get_config(win).relative == "" end,
        },
        "Trouble",
        { ft = "qf", title = "QuickFix" },
        {
            ft = "help",
            size = { height = 20 },
            -- only show help buffers
            filter = function(buf) return vim.bo[buf].buftype == "help" end,
        },
        { title = "Neotest Output", ft = "neotest-output-panel", size = { height = 15 } },
        -- { ft = "spectre_panel", size = { height = 0.4 } },
    },
    left = {
        -- Neo-tree filesystem always takes half the screen height
        {
            title = "Files",
            ft = "neo-tree",
            filter = function(buf) return vim.b[buf].neo_tree_source == "filesystem" end,
            size = { height = 0.5, width = 0.15 },
            pinned = true,
            open = "Neotree show position=left filesystem",
        },
        {
            title = "Git",
            ft = "neo-tree",
            filter = function(buf) return vim.b[buf].neo_tree_source == "git_status" end,
            pinned = true,
            -- collapsed = true, -- show window as closed/collapsed on start
            open = "Neotree show position=left git_status",
        },
        {
            title = "Buffers",
            ft = "neo-tree",
            filter = function(buf) return vim.b[buf].neo_tree_source == "buffers" end,
            pinned = true,
            -- collapsed = true, -- show window as closed/collapsed on start
            open = "Neotree show position=left buffers",
        },
        { title = "Tests", ft = "neotest-summary" },
        -- any other neo-tree windows
        -- "neo-tree",
    },
    right = {
        { title = "Debug", ft = "dap-view", size = { width = 90 }, wo = { winbar = false } },
        { title = "Debug", ft = "dap-repl", size = { width = 90 }, wo = { winbar = false } },
        { title = "Debug Term", ft = "dap-view-term", size = { width = 90 }, wo = { winbar = false } },
        { title = "Search & replace", ft = "grug-far", size = { width = 0.25 } },
        { title = "Outline", ft = "sagaoutline", size = { width = 0.18 } },
        { title = "Outline", ft = "Outline", size = { width = 0.18 } },
        { title = "Code Companion", ft = "codecompanion", size = { width = 0.25 } },
        { title = "Copilot", ft = "copilot-chat", size = { width = 0.25 } },
        { title = "OpenCode", ft = "opencode_output", size = { width = 0.25 } },
        { title = "OpenCode", ft = "opencode_input", size = { width = 0.25 } },
        -- { title = "Avante", ft = "Avante", size = { width = 70 } },
    },
}

-- trouble
for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
    opts[pos] = opts[pos] or {}
    table.insert(opts[pos], {
        ft = "trouble",
        filter = function(_buf, win)
            return vim.w[win].trouble
                and vim.w[win].trouble.position == pos
                and vim.w[win].trouble.type == "split"
                and vim.w[win].trouble.relative == "editor"
                and not vim.w[win].trouble_preview
        end,
    })
end

return opts
