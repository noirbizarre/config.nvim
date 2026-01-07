vim.filetype.add({
    extension = {
        jinja = "jinja",
        jinja2 = "jinja",
        j2 = "jinja",
        avanterules = "jinja.markdown",
    },
    pattern = {
        -- Known templates
        [".*/.+%.jinja%..+"] = "jinja",
        [".*/.+%.j2%..+"] = "jinja",
        [".*/copier%.yml"] = "jinja.yaml",
    },
})

-- Automatically set filetype and start LSP for systemd and Podman Quadlet unit files
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    group = vim.api.nvim_create_augroup("jinja_filetype", { clear = true }),
    desc = "Set composite filetype for Jinja templates",
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local filename = vim.api.nvim_buf_get_name(0)
        local ft = vim.filetype.match({ filename = filename, buf = bufnr })
        if ft ~= "jinja" or type(bufnr) ~= "number" or not vim.api.nvim_buf_is_valid(bufnr) then
            return
        end
        -- local basename = vim.fs.basename(filename)
        for _, ext in ipairs({ "jinja", "jinja2", "j2" }) do
            filename = filename:gsub("%." .. ext, "")
        end

        local raw_ft = vim.filetype.match({ filename = filename, buf = bufnr })
        if raw_ft ~= nil then
            raw_ft = raw_ft:gsub("jinja", ""):gsub("%.", "")
            vim.bo.filetype = "jinja." .. raw_ft
        end
    end,
})

vim.treesitter.query.add_directive("inject-jinja!", function(_, _, bufnr, _, metadata)
    if type(bufnr) ~= "number" or not vim.api.nvim_buf_is_valid(bufnr) then
        return
    end
    local ft = vim.bo[bufnr].filetype
    if ft == nil then
        return
    end
    local raw_ft = nil
    if ft:find(".jinja", 1, true) ~= nil then
        raw_ft = ft:gsub("%.jinja", "")
    elseif ft:find("jinja.", 1, true) ~= nil then
        raw_ft = ft:gsub("jinja%.", "")
    end
    if raw_ft == nil then
        return
    end
    local lang = vim.treesitter.language.get_lang(raw_ft)
    if lang == nil then
        return
    end
    metadata["injection.language"] = lang
end, {})

return {
    "noirbizarre/ensure.nvim",
    opts = {
        lsp = {
            enable = { "jinja_lsp" },
        },
    },
}
