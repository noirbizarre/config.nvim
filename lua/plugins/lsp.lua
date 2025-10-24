local LSPs = {
    "basedpyright",
    "bashls",
    "clangd",
    "docker_compose_language_service",
    "dockerls",
    "gh_actions_ls",
    "helm_ls",
    "jinja_lsp",
    "jsonls",
    "ltex_plus",
    "lua_ls",
    "marksman",
    "ruff",
    "sqlls",
    "tombi",
    -- "taplo",
    -- "ty",
    "vimls",
    "yamlls",
}

return {
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        cmd = {
            "LspInstall",
            "LspUninstall",
        },
        opts = {
            automatic_enable = false,
            ensure_installed = LSPs,
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
            "mason-org/mason.nvim",
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
        keys = {
            { "<leader>ky", function() require("yaml-companion").open_ui_select() end, desc = "YAML Schema" },
        },

        config = function()
            local icons = require("lib.ui.icons")

            vim.lsp.enable(LSPs)

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

            vim.lsp.config("ty", {
                init_options = {
                    settings = {
                        ty = {
                            experimental = {
                                completions = {
                                    enable = true,
                                },
                            },
                        },
                    },
                },
            })
            vim.lsp.config("basedpyright", {
                settings = {
                    basedpyright = {
                        analysis = {
                            autoImportCompletions = true,
                            -- diagnosticMode = "workspace",
                            typeCheckingMode = "standard",
                        },
                    },
                },
            })
            vim.lsp.config("jsonls", {
                settings = {
                    json = {
                        schemas = require("schemastore").json.schemas(),
                        validate = { enable = true },
                    },
                },
            })
            vim.lsp.config("dockerls", {
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
            vim.lsp.config("gh_actions_ls", {
                init_options = {
                    sessionToken = vim.env.GITHUB_TOKEN,
                },
            })
            vim.lsp.config("ltex_plus", {
                settings = {
                    ltex = {
                        checkFrequency = "save",
                        language = { "en-US", "fr" },
                        additionalRules = {
                            enablePickyRules = true,
                            motherTongue = { "fr" },
                        },
                    },
                },
            })

            -- YANL companion
            -- cf. https://www.arthurkoziel.com/json-schemas-in-neovim/
            local yaml_cfg = require("yaml-companion").setup({
                -- detect k8s schemas based on file content
                builtin_matchers = {
                    kubernetes = { enabled = true },
                },

                -- schemas available in the picker
                schemas = {
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
                    -- capabilities = capabilities,
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
            vim.lsp.config("yamlls", yaml_cfg)

            vim.diagnostic.config({
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
                        [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
                        [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
                        [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
                    },
                    numhl = {
                        [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
                        [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
                        [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
                        [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
                    },
                },
                severity_sort = true,
                -- virtual_lines = true,
            })
        end,
    },

    --- Linters
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
            local selene_or_luacheck = function()
                if vim.fs.find({ ".luacheckrc" }, { path = vim.uv.cwd(), upward = true })[1] then
                    return "luacheck"
                end
                return "selene"
            end
            lint.linters_by_ft = {
                dockerfile = { "hadolint" },
                json = { "jsonlint" },
                lua = { selene_or_luacheck() },
                markdown = { "vale" },
                rst = { "vale" },
                ruby = { "ruby" },
                sql = { "sqlfluff" },
                terraform = { "tflint" },
                text = { "vale" },
            }
        end,
    },
    --- Automatically install linters
    {
        "rshkarin/mason-nvim-lint",
        dependencies = {
            "mason-org/mason.nvim",
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
        lazy = false,
        dependencies = { "neovim/nvim-lspconfig", "mfussenegger/nvim-dap-python" },
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
