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
            "yamlls",
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
            "someone-stole-my-name/yaml-companion.nvim",
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

            -- YANL companion
            -- cf. https://www.arthurkoziel.com/json-schemas-in-neovim/
            local yaml_cfg = require("yaml-companion").setup {
                -- detect k8s schemas based on file content
                builtin_matchers = {
                    kubernetes = { enabled = true }
                },

                -- schemas available in Telescope picker
                schemas = {
                    -- not loaded automatically, manually select with
                    -- :Telescope yaml_schema
                    {
                        name = "Argo CD Application",
                        uri = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json"
                    },
                    -- schemas below are automatically loaded, but added
                    -- them here so that they show up in the statusline
                    {
                        name = "GitHub Workflow",
                        uri = "https://json.schemastore.org/github-workflow.json"
                    },
                },

                lspconfig = {
                    settings = {
                        yaml = {
                            validate = true,
                            schemaStore = {
                                enable = false,
                                url = ""
                            },
                            -- schemas from store, matched by filename
                            -- loaded automatically
                            schemas = require('schemastore').yaml.schemas {
                                extra = {
                                    {
                                        url = 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json',
                                        name = 'Argo CD Application',
                                        description = 'Argo CD Application Schema (v1alpha1)',
                                        fileMatch = 'argocd-application.yaml'
                                    },
                                },
                            },
                        },
                    },
                },
            }

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
            lspconfig.yamlls.setup(yaml_cfg)

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
