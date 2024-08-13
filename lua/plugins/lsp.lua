return {
    --- Fetch LSP binaries
    {
        "williamboman/mason.nvim",
        cmd = {
            "Mason",
            "MasonInstall",
            "MasonUninstall",
            "MasonUninstallAll",
            "MasonLog",
        },
        config = true,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim"
        },
        cmd = {
            "LspInstall",
            "LspUninstall",
        },
        ensure_installed = {
            --   "prettierd",
            "luacheck",
            "ruff_lsp",
            "bashls",
            "stylua",
            "lua_ls",
            "pylsp",
            "taplo",
            "jsonls",
            "rust_analyzer",
            -- "pylsp",
            "basedpyright",
            -- "pyright",
            --   "deno",
            --   "eslint_d",
            --   "selene",
            --   "shfmt",
        },
        config = function()
            require("mason-lspconfig").setup()
        end,
    },

    -- lsp servers
    {
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
        cmd = {
            "LspInfo",
            "LspStart",
            "LspStop",
            "LspRestart",
        },
        dependencies = {
            -- json schemas
            "b0o/schemastore.nvim",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
		    "onsails/lspkind-nvim",
            --- NeoConf - Configure LSP from workspace neoconf.json
            --- https://github.com/folke/neoconf.nvim
            { "folke/neoconf.nvim", config = true },
            --- NeoDev - Lua dev helpers
            --- https://github.com/folke/neodev.nvim
            { "folke/neodev.nvim", config = true },
        },

        config = function()
            local lspconfig = require("lspconfig")
            local icons = require("config.ui").icons

            -- Install manual dependencies if required
            require("mason-registry"):on("package:install:success", function(pkg)
                if pkg.name ~= "python-lsp-server" then
                    return
                end

                vim.schedule(function()
                    vim.api.nvim_command(":PylspInstall pyls-flake8 pylsp-mypy python-lsp-ruff python-lsp-black")
                end)
            end)

            lspconfig.bashls.setup{}
            lspconfig.lua_ls.setup{}
            -- lspconfig.pylsp.setup{}
            -- lspconfig.pyright.setup{}
            lspconfig.basedpyright.setup{}
            lspconfig.ruff_lsp.setup{}
            lspconfig.jsonls.setup{
                settings = {
                    json = {
                      schemas = require('schemastore').json.schemas(),
                      validate = { enable = true },
                    },
                },
            }
            lspconfig.rust_analyzer.setup{
                settings = {
                    ["rust-analyzer"] = {
                        cargo = { allFeatures = true },
                        checkOnSave = {
                            command = "clippy",
                            extraArgs = { "--no-deps" },
                        },
                    },
                },
            }
            lspconfig.vimls.setup{}
            lspconfig.jinja_lsp.setup{}

            -- replace the default lsp diagnostic symbols
            for name, icon in pairs(icons.diagnostics) do
                local hl = "DiagnosticSign" .. name
                vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
            end

            vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
                signs = true,
                severity_sort = true,
                symbols = true,
                underline = true,
                update_in_insert = false,
                virtual_text = true,
            })
        end,
    },

    -- {
    --     "tamago324/nlsp-settings.nvim",
    -- },

    -- null-ls
    {
        "nvimtools/none-ls.nvim",
        event = "BufReadPre",
        config = function()
            local nls = require("null-ls")
            nls.setup({
                -- debounce = 150,
                -- save_after_format = false,
                sources = {
                    -- nls.builtins.formatting.prettierd,
                    nls.builtins.formatting.stylua,
                    -- nls.builtins.completion.spell,
                    -- nls.builtins.diagnostics.shellcheck,
                    -- nls.builtins.formatting.fish_indent,
                    -- nls.builtins.formatting.fixjson.with({ filetypes = { "jsonc" } }),
                    -- nls.builtins.formatting.eslint_d,
                    -- nls.builtins.formatting.shfmt,
                    -- nls.builtins.diagnostics.markdownlint,
                    -- nls.builtins.diagnostics.luacheck,
                    -- nls.builtins.formatting.prettierd.with({
                    --     filetypes = { "markdown" }, -- only runs `deno fmt` for markdown
                    -- }),
                    -- nls.builtins.diagnostics.selene.with({
                    --     condition = function(utils)
                    --         return utils.root_has_file({ "selene.toml" })
                    --     end,
                    -- }),
                    -- nls.builtins.code_actions.gitsigns,
                    -- nls.builtins.formatting.isort,
                    -- nls.builtins.formatting.black,
                    -- nls.builtins.diagnostics.flake8,
                },
                -- root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", ".git"),
            })
        end,
    },
}
