vim.filetype.add({
    extension = {
        --- Systemd unit files
        systemd = "systemd",
        service = "systemd",
        timer = "systemd",
        socket = "systemd",
        mount = "systemd",
        automount = "systemd",
        swap = "systemd",
        target = "systemd",
        path = "systemd",
        slice = "systemd",
        scope = "systemd",
        network = "systemd",
        netdev = "systemd",
        -- Podman Quadlets
        container = "systemd",
        volume = "systemd",
        kube = "systemd",
        pod = "systemd",
        build = "systemd",
        image = "systemd",
    },
    pattern = {
        [".*/etc/systemd/system/.+%.conf"] = "systemd",
        [".*/usr/lib/systemd/system/.+%.conf"] = "systemd",
        [".*/lib/systemd/system/.+%.conf"] = "systemd",
    },
})

vim.treesitter.language.register("dosini", { "systemd" })

return {
    "noirbizarre/ensure.nvim",
    opts = {
        lsp = {
            enable = { "systemd_lsp" },
        },
    },
}
