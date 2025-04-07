-- Setup lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        --- Mason - Fetch binaries
        --- https://github.com/williamboman/mason.nvim
        {
            "williamboman/mason.nvim",
            cmd = {
                "Mason",
                "MasonInstall",
                "MasonUninstall",
                "MasonUninstallAll",
                "MasonLog",
            },
            opts = {
                -- ui = {
                --     border = "rounded",
                -- },
            },
        },
        -- import your plugins
        { import = "plugins" },
        { import = "plugins.features" },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "solarized-osaka" } },
    dev = {
        path = "~/Workspaces/neovim",
    },
    -- automatically check for plugin updates
    -- checker = { enabled = true },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
    -- ui = {
    --     border = "rounded",
    -- },
})
