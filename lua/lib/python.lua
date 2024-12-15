local M = {}

-- Automate the installation of pylsp modules in it's virtualenv.
M.mason_post_install = function(pkg)
    if pkg.name ~= "python-lsp-server" then
        return
    end

    vim.schedule(function() vim.api.nvim_command(":PylspInstall pylsp-mypy python-lsp-ruff python-lsp-black") end)

    -- local venv = vim.fn.stdpath("data") .. "/mason/packages/python-lsp-server/venv"
    -- local job = require("plenary.job")

    -- job:new({
    --     command = venv .. "/bin/pip",
    --     args = {
    --         "install",
    --         "-U",
    --         "--disable-pip-version-check",
    --         "pylsp-mypy",
    --         "python-lsp-ruff",
    --         "python-lsp-black",
    --     },
    --     cwd = venv,
    --     env = { VIRTUAL_ENV = venv },
    --     on_exit = function()
    --         vim.notify("Finished installing pylsp modules.")
    --     end,
    --     on_start = function()
    --         vim.notify("Installing pylsp modules...")
    --     end,
    -- }):start()
end

return M
