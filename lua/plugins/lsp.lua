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
            "someone-stole-my-name/yaml-companion.nvim",
            --  Faster LuaLS setup for Neovim
            -- https://github.com/folke/lazydev.nvim
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
            {
                "barreiroleo/ltex_extra.nvim",
                branch = "dev",
                -- ft = { "markdown", "tex" },
                opts = {
                    load_langs = { "en-US", "fr-FR" },
                },
            },
            --- For LSP Cpabilities
            --- See: https://cmp.saghen.dev/installation.html
            "saghen/blink.cmp",
        },

        config = function()
            local lspconfig = require("lspconfig")
            local configs = require("lspconfig.configs")
            local icons = require("lib.ui.icons")
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            -- Exclude big directories from being watched
            vim.lsp._watchfiles._poll_exclude_pattern = vim.lsp._watchfiles._poll_exclude_pattern
                -- Standard cache dirs
                + vim.glob.to_lpeg("**/.*_cache/**")
                -- Virtualenv (Need LSP restart)
                + vim.glob.to_lpeg("**/.venv/**")
                -- JS/TS
                + vim.glob.to_lpeg("**/.yarn/**")
                + vim.glob.to_lpeg("**/node_modules/**")
                -- rust build assets
                + vim.glob.to_lpeg("**/target/**")

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
                    capabilities = capabilities,
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

            lspconfig.bashls.setup({ capabilities = capabilities })
            lspconfig.lua_ls.setup({ capabilities = capabilities })
            lspconfig.basedpyright.setup({
                capabilities = capabilities,
                settings = {
                    basedpyright = {
                        analysis = {
                            autoImportCompletions = true,
                            diagnosticMode = "workspace",
                            typeCheckingMode = "standard",
                        },
                    },
                },
            })
            lspconfig.ruff.setup({ capabilities = capabilities })
            lspconfig.jsonls.setup({
                capabilities = capabilities,
                settings = {
                    json = {
                        schemas = require("schemastore").json.schemas(),
                        validate = { enable = true },
                    },
                },
            })
            lspconfig.rust_analyzer.setup({
                capabilities = capabilities,
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
            lspconfig.helm_ls.setup({ capabilities = capabilities })
            lspconfig.taplo.setup({ capabilities = capabilities })
            lspconfig.vale_ls.setup({ capabilities = capabilities })
            lspconfig.vimls.setup({ capabilities = capabilities })
            lspconfig.jinja_lsp.setup({ capabilities = capabilities })
            lspconfig.marksman.setup({ capabilities = capabilities })
            lspconfig.clangd.setup({ capabilities = capabilities })
            lspconfig.yamlls.setup(yaml_cfg)
            lspconfig.docker_compose_language_service.setup({ capabilities = capabilities })
            lspconfig.dockerls.setup({
                capabilities = capabilities,
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
            lspconfig.ltex_plus.setup({
                capabilities = capabilities,
                settings = {
                    ltex = {
                        checkFrequency = "save",
                        language = { "en-US", "fr" },
                        languageToolHttpServerUri = "https://api.languagetoolplus.com/",
                        languageToolOrg = {
                            username = vim.env.LANGUETOOL_USER,
                            apikey = vim.env.LANGUETOOL_APIKEY,
                        },
                        additionalRules = {
                            enablePickyRules = true,
                            motherTongue = { "fr" },
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
                    -- virtual_text = true,
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
                function() require("lint").try_lint() end,
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
        branch = "regexp",
        lazy = false,
        dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
        -- event = 'VeryLazy', -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
        keys = {
            { "<leader>lv", "<cmd>VenvSelect<cr>", desc = "Select virtualenv", ft = "python" },
        },
        ft = "python",
        ---@type venv-selector.Config
        opts = {
            options = {
                picker = "native",
            },
            notify_user_on_venv_activation = true,
            -- debug = true,
        },
    },
}
