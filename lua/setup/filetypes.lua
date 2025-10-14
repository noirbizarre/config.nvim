vim.filetype.add({
    extension = {
        jinja = "jinja",
        jinja2 = "jinja",
        j2 = "jinja",
        alias = "sh",
        wiz = "yaml",
        avanterules = "jinja.markdown",
    },
    pattern = {
        -- Helm Charts
        [".*/templates/.+%.yaml"] = "helm",
        [".*/kitty/.+%.conf"] = "kitty",
        [".*/hypr/.+%.conf"] = "hyprlang",
        [".*/hypr%.conf"] = "hyprlang",
        -- VSCode JSONC
        [".*/%.vscode/.+%.json"] = "jsonc",
        -- dotfiles
        [".*/%.local/bin/*"] = "sh",
        [".*/%.alias%.d/.+%.alias"] = "sh",
        [".*/%.env%.d/.+%.path"] = "sh",
        [".*/%.config/tmux/.+%.conf"] = "tmux",
        -- ["%.env%.[%w_.-]+"] = "sh",
        [".*/.+%.secret"] = "sh",
        -- Known templates
        [".*/.+%.jinja%..+"] = "jinja",
        [".*/.+%.j2%..+"] = "jinja",
        [".*/copier%.yml"] = "jinja.yaml",
    },
})

vim.treesitter.language.register("bash", "kitty")
vim.treesitter.language.register("properties", { "jproperties" })

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
