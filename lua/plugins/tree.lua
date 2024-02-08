return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    keys = {
        { "<C-b>", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
    },
    cmd = "Neotree",
    config = function ()
        -- Unless you are still migrating, remove the deprecated commands from v1.x
        vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

        require("neo-tree").setup({
            close_if_last_window = true,
            use_libuv_file_watcher=true,
            enable_git_status = true,
            enable_diagnostics = true,
            sort_case_insensitive = true,
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                },
            },
        })
    end,
}
