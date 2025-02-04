local M = {}

local SEPARATOR = { name = "separator" }

M.context_menu = function()
    require("menu.utils").delete_old_menus()

    vim.cmd.exec('"normal! \\<RightMouse>"')

    -- clicked buf
    local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
    local options = vim.bo[buf].ft == "neo-tree" and M.neotree() or M.default()
    -- local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or M.default()

    require("menu").open(options, { mouse = true })
end

--- Default menu
M.default = function()
    local minty = require("minty.utils")
    local items = {
        {
            name = "Format Buffer",
            cmd = function()
                local ok, conform = pcall(require, "conform")

                if ok then
                    conform.format({ lsp_fallback = true })
                else
                    vim.lsp.buf.format()
                end
            end,
            rtxt = "<leader>rf",
        },
        {
            name = "Code Actions",
            cmd = vim.lsp.buf.code_action,
            rtxt = "<leader>la",
        },
        SEPARATOR,
        {
            name = "  Lsp Actions",
            hl = "Exblue",
            items = M.lsp_actions(),
        },
        SEPARATOR,
        {
            name = "  Copy",
            cmd = "%y+",
            rtxt = "<C-c>",
        },
        {
            name = "  Delete",
            cmd = "%d",
            rtxt = "dc",
            hl = "ExRed",
        },
        SEPARATOR,
        {
            name = "  Open in terminal",
            hl = "ExGreen",
            cmd = function()
                local old_buf = require("menu.state").old_data.buf
                local old_bufname = vim.api.nvim_buf_get_name(old_buf)
                local old_buf_dir = vim.fn.fnamemodify(old_bufname, ":h")

                Snacks.terminal(nil, { cwd = old_buf_dir })
            end,
        },
    }
    if minty.hex_on_cursor() ~= nil then
        items[#items + 1] = SEPARATOR
        items[#items + 1] = {
            name = "  Color Picker",
            cmd = function() require("minty.huefy").open() end,
            hl = "RainbowViolet",
        }
    end
    return items
end

--- LSP Sub menu
M.lsp_actions = function()
    return {
        {
            name = "Goto Definition",
            cmd = vim.lsp.buf.definition,
            rtxt = "gd",
        },
        {
            name = "Goto Declaration",
            cmd = vim.lsp.buf.declaration,
            rtxt = "gD",
        },
        {
            name = "Goto Implementation",
            cmd = vim.lsp.buf.implementation,
            rtxt = "gi",
        },
        SEPARATOR,
        {
            name = "Show signature help",
            cmd = vim.lsp.buf.signature_help,
            rtxt = "<leader>sh",
        },
        {
            name = "Add workspace folder",
            cmd = vim.lsp.buf.add_workspace_folder,
            rtxt = "<leader>wa",
        },
        {
            name = "Remove workspace folder",
            cmd = vim.lsp.buf.remove_workspace_folder,
            rtxt = "<leader>wr",
        },
        {
            name = "Show References",
            cmd = vim.lsp.buf.references,
            rtxt = "gr",
        },
        SEPARATOR,
        {
            name = "Format Buffer",
            cmd = function()
                local ok, conform = pcall(require, "conform")

                if ok then
                    conform.format({ lsp_fallback = true })
                else
                    vim.lsp.buf.format()
                end
            end,
            rtxt = "<leader>fm",
        },
        {
            name = "Code Actions",
            cmd = vim.lsp.buf.code_action,
            rtxt = "<leader>ca",
        },
    }
end

M.neotree = function()
    local state = require("neo-tree.sources.manager").get_state("filesystem")
    local fs = require("neo-tree.sources.filesystem.commands")
    local node = state.tree:get_node()

    return {
        {
            name = "  New file",
            cmd = function()
                vim.defer_fn(function() fs.add(state) end, 1)
            end,
            rtxt = "a",
        },
        {
            name = "  New folder",
            cmd = function()
                vim.defer_fn(function() fs.add_directory(state) end, 1)
            end,
            rtxt = "a", -- Same key as for creating a new file or directory
        },
        SEPARATOR,
        {
            name = "  Open in window",
            cmd = function() fs.open(state) end,
            rtxt = "o",
        },
        {
            name = "  Open in vertical split",
            cmd = function() fs.open_vsplit(state) end,
            rtxt = "v",
        },
        {
            name = "  Open in horizontal split",
            cmd = function() fs.open_split(state) end,
            rtxt = "s",
        },
        SEPARATOR,
        {
            name = "  Cut",
            cmd = function() fs.cut_to_clipboard(state) end,
            rtxt = "x",
        },
        {
            name = "  Paste",
            cmd = function() fs.paste_from_clipboard(state) end,
            rtxt = "p",
        },
        {
            name = "  Copy",
            cmd = function() fs.copy_to_clipboard(state) end,
            rtxt = "c",
        },
        {
            name = "󰴠  Copy path",
            cmd = function() vim.fn.setreg("+", node:get_id()) end,
            rtxt = "gy",
        },
        SEPARATOR,
        {
            name = "  Open in terminal",
            hl = "ExGreen",
            cmd = function()
                local path = node:get_id()
                local node_type = vim.uv.fs_stat(path).type
                local dir = node_type == "directory" and path or vim.fn.fnamemodify(path, ":h")
                Snacks.terminal(nil, { cwd = dir })
            end,
        },
        SEPARATOR,
        {
            name = "  Rename",
            cmd = function()
                vim.defer_fn(function() fs.rename(state) end, 0)
            end,
            rtxt = "r",
        },
        {
            name = "  Delete",
            hl = "ExRed",
            cmd = function()
                vim.defer_fn(function() fs.delete(state) end, 0)
            end,
            rtxt = "d",
        },
    }
end

M.gitsigns = function()
    return {

        {
            name = "Stage Hunk",
            cmd = "Gitsigns stage_hunk",
            rtxt = "sh",
        },
        {
            name = "Reset Hunk",
            cmd = "Gitsigns reset_hunk",
            rtxt = "rh",
        },

        {
            name = "Stage Buffer",
            cmd = "Gitsigns stage_buffer",
            rtxt = "sb",
        },
        {
            name = "Undo Stage Hunk",
            cmd = "Gitsigns undo_stage_hunk",
            rtxt = "us",
        },
        {
            name = "Reset Buffer",
            cmd = "Gitsigns reset_buffer",
            rtxt = "rb",
        },
        {
            name = "Preview Hunk",
            cmd = "Gitsigns preview_hunk",
            rtxt = "hp",
        },
        SEPARATOR,
        {
            name = "Blame Line",
            cmd = 'lua require"gitsigns".blame_line{full=true}',
            rtxt = "b",
        },
        {
            name = "Toggle Current Line Blame",
            cmd = "Gitsigns toggle_current_line_blame",
            rtxt = "tb",
        },
        SEPARATOR,
        {
            name = "Diff This",
            cmd = "Gitsigns diffthis",
            rtxt = "dt",
        },
        {
            name = "Diff Last Commit",
            cmd = 'lua require"gitsigns".diffthis("~")',
            rtxt = "dc",
        },
        {
            name = "Toggle Deleted",
            cmd = "Gitsigns toggle_deleted",
            rtxt = "td",
        },
    }
end

return M
