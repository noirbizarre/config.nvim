local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

---
-- Normal mode
---

-- Close buffer and display previous buffer in current window
keymap("n", "<leader>q", ":b#<bar>bd#<cr>", opts)
