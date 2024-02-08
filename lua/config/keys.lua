local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

---
-- Normal mode
---

-- Normal mode

-- Move to previous/next
-- keymap("n", "<C-Left>", ":BufferLineCyclePrev<cr>", opts)
-- keymap("n", "<C-Right>", ":BufferLineCycleNext<cr>", opts)

-- Re-order to previous/next
-- keymap("n", "<C-M-Left>", ":BufferLineMovePrev<cr>", opts)
-- keymap("n", "<C-M-Right>", " :BufferLineMoveNext<cr>", opts)

-- Sidebar (NeoTree)
-- keymap("n", "<C-B>", ":Neotree<cr>", opts)

-- Terminal
-- keymap("n", "<C-T>", ":ToggleTerm<cr>", opts)
