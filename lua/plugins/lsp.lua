return {
    --- https://github.com/williamboman/mason-lspconfig.nvim
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
        cmd = {
            "LspInstall",
            "LspUninstall",
        },
        opts = {
            automatic_installation = true,
        },
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
            local icons = require("lib.ui.icons")

            -- YANL companion
            -- cf. https://www.arthurkoziel.com/json-schemas-in-neovim/
            local yaml_cfg = require("yaml-companion").setup({
                -- detect k8s schemas based on file content
                builtin_matchers = {
                    kubernetes = { enabled = true },
                },

                -- schemas available in Telescope picker
                schemas = {
                    -- not loaded automatically, manually select with
                    -- :Telescope yaml_schema
                    {
                        name = "Argo CD Application",
                        uri = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json",
                    },
                    -- schemas below are automatically loaded, but added
                    -- them here so that they show up in the statusline
                    {
                        name = "GitHub Workflow",
                        uri = "https://json.schemastore.org/github-workflow.json",
                    },
                },

                lspconfig = {
                    settings = {
                        yaml = {
                            validate = true,
                            schemaStore = {
                                enable = false,
                                url = "",
                            },
                            -- schemas from store, matched by filename
                            -- loaded automatically
                            schemas = require("schemastore").yaml.schemas({
                                extra = {
                                    {
                                        url = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json",
                                        name = "Argo CD Application",
                                        description = "Argo CD Application Schema (v1alpha1)",
                                        fileMatch = "argocd-application.yaml",
                                    },
                                },
                            }),
                        },
                    },
                },
            })

            lspconfig.bashls.setup({})
            lspconfig.lua_ls.setup({})
            lspconfig.basedpyright.setup({
                settings = {
                    basedpyright = {
                        typeCheckingMode = "standard",
                    },
                },
            })
            lspconfig.ruff.setup({})
            lspconfig.jsonls.setup({
                settings = {
                    json = {
                        schemas = require("schemastore").json.schemas(),
                        validate = { enable = true },
                    },
                },
            })
            lspconfig.rust_analyzer.setup({
                settings = {
                    ["rust-analyzer"] = {
                        cargo = { allFeatures = true },
                        checkOnSave = {
                            command = "clippy",
                            extraArgs = { "--no-deps" },
                        },
                    },
                },
            })
            lspconfig.helm_ls.setup({})
            lspconfig.taplo.setup({})
            lspconfig.vale_ls.setup({})
            lspconfig.vimls.setup({})
            lspconfig.jinja_lsp.setup({})
            lspconfig.yamlls.setup(yaml_cfg)
            lspconfig.docker_compose_language_service.setup({})
            lspconfig.dockerls.setup({
                settings = {
                    docker = {
                        languageserver = {
                            formatter = {
                                ignoreMultilineInstructions = true,
                            },
                        },
                    },
                },
            })

            -- replace the default lsp diagnostic symbols
            for name, icon in pairs(icons.diagnostics) do
                local hl = "DiagnosticSign" .. name
                vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
            end

            vim.lsp.handlers["textDocument/publishDiagnostics"] =
                vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
                    signs = true,
                    severity_sort = true,
                    symbols = true,
                    underline = true,
                    update_in_insert = false,
                    virtual_text = true,
                })
        end,
    },

    --- Linters
    --- https://github.com/mfussenegger/nvim-lint
    {
        "mfussenegger/nvim-lint",
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        keys = {
            {
                "<leader>ll",
                function()
                    require("lint").try_lint()
                end,
                desc = "Lint",
            },
        },
        config = function()
            local lint = require("lint")
            lint.linters_by_ft = {
                text = { "vale" },
                json = { "jsonlint" },
                markdown = { "vale" },
                rst = { "vale" },
                ruby = { "ruby" },
                dockerfile = { "hadolint" },
                terraform = { "tflint" },
                lua = { "selene", "luacheck" },
            }
            lint.linters = {
                selene = {
                    condition = function(ctx)
                        local root = vim.uv.cwd()
                        return vim.fs.find({ "selene.toml" }, { path = root, upward = true })[1]
                    end,
                },
                luacheck = {
                    condition = function(ctx)
                        return vim.fs.find({ ".luacheckrc" }, { path = vim.uv.cwd(), upward = true })[1]
                    end,
                },
            }
        end,
    },
    --- https://github.com/rshkarin/mason-nvim-lint
    {
        "rshkarin/mason-nvim-lint",
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-lint",
        },
        opts = {
            ignore_install = { "janet", "inko", "clj-kondo", "ruby" },
        },
    },
    -- Virtualenv auto selection and picker
    -- https://github.com/linux-cultist/venv-selector.nvim
    {
        "linux-cultist/venv-selector.nvim",
        dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
        -- event = 'VeryLazy', -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
        keys = {
            -- Keymap to open VenvSelector to pick a venv.
            { "<leader>vs", "<cmd>VenvSelect<cr>" },
            -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
            { "<leader>vc", "<cmd>VenvSelectCached<cr>" },
        },
        opts = {
            name = { "venv", ".venv" },
        },
    },
}
