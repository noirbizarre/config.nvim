vim.filetype.add({
    extension = {
        jinja = "jinja",
        jinja2 = "jinja",
        j2 = "jinja",
        alias = "sh",
        wiz = "yaml",
    },
    pattern = {
        [".*/kitty/.+%.conf"] = "kitty",
        [".*/hypr/.+%.conf"] = "hyprlang",
        -- dotfiles
        [".*/%.local/bin/*"] = "sh",
        [".*/%.alias%.d/.+%.alias"] = "sh",
        [".*/%.env%.d/.+%.path"] = "sh",
        -- ["%.env%.[%w_.-]+"] = "sh",
        [".*/.+%.secret"] = "sh",
    },
})

vim.treesitter.language.register("bash", "kitty")
vim.treesitter.language.register("properties", { "jproperties" })
