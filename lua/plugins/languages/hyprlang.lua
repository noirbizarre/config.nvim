vim.filetype.add({
    pattern = {
        [".*/hypr/.+%.conf"] = "hyprlang",
        [".*/hypr%.conf"] = "hyprlang",
    },
})

return {}
