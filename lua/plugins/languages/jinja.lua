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

vim.treesitter.query.add_directive("inject-jinja!", function(_, _, bufnr, _, metadata)
    if type(bufnr) ~= "number" or not vim.api.nvim_buf_is_valid(bufnr) then
        return
    end
    local basename = vim.fs.basename(vim.api.nvim_buf_get_name(bufnr))
    for _, ext in ipairs({ "jinja", "jinja2", "j2" }) do
        basename = basename:gsub("%." .. ext, "")
    end

    local ft = vim.filetype.match({ filename = basename, buf = bufnr })
    if ft ~= nil then
        local raw_ft = ft:gsub("jinja", ""):gsub("%.", "")
        metadata["injection.language"] = raw_ft
    end
end, {})

local LSPs = {
    "jinja_lsp",
}

return {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = LSPs,
        },
    },
    {
        "neovim/nvim-lspconfig",
        opts = function() vim.lsp.enable(LSPs) end,
    },
}
