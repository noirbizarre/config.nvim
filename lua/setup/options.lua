-- LEADER
-- The <leader> keybindings need to be defined before the first /
-- is called; otherwise, it will default to "\"
-- (see `:h mapleader` for more info)
vim.g.mapleader = " "
vim.g.localleader = "\\"

-- Language (Force English)
--vim.cmd.language("en_US")

-- Enable highlight on search
vim.opt.hlsearch = true

-- Highlight match while typing search pattern
vim.opt.incsearch = true

-- Make line numbers default
vim.opt.number = true

-- Highlight cursor line and column
vim.opt.cursorline = true
vim.opt.cursorcolumn = true

-- Do not save when switching buffers
vim.opt.hidden = true

-- Configure the number of spaces a tab is counting for
vim.opt.tabstop = 4

-- Number of spaces for a step of indent
vim.opt.shiftwidth = 4

-- Transform tabs into spaces
vim.opt.expandtab = true

-- Backspace everything
vim.opt.backspace = [[indent,eol,start]]

-- Session Persistence
vim.opt.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,terminal"

-- Disable swap files
vim.opt.swapfile = false

-- Set python3 interpreter
vim.g.python3_host_prog = "/usr/bin/python3"

-- Disable some builtin providers
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Do not load system vimfiles
vim.api.nvim_command("set rtp-=/usr/share/vim/vimfiles")

--- GUI settings
vim.opt.guifont = "FiraCode Nerd Font:h10"

-- Neovide configuration
if vim.g.neovide then
    vim.g.neovide_transparency = 0.9
    -- vim.g.neovide_fullscreen = true
    -- vim.api.nvim_set_hl(0, 'Normal', { bg = "#041D2B" })
end
