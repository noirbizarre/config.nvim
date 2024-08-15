return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
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
            use_libuv_file_watcher = true,
            enable_git_status = true,
            enable_diagnostics = true,
            sort_case_insensitive = true,
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                },
                follow_current_file = {
                    enabled = true, -- This will find and focus the file in the active buffer every time
                    --               -- the current file is changed while the tree is open.
                    -- leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
                },
                use_libuv_file_watcher = true,
            },
            default_component_configs = {
                symlink_target = { enabled = true },
            },
        })
    end,
}
