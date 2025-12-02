return {
    {
        "mason-org/mason-lspconfig.nvim",
        ensure_installed = {
            "basedpyright",
            "ruff",
            -- "ty",
        },
    },
    {
        "neovim/nvim-lspconfig",
        opts = function()
            vim.lsp.enable({
                "basedpyright",
                "ruff",
                -- "ty",
            })

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
                            diagnosticMode = "workspace",
                            typeCheckingMode = "standard",
                        },
                    },
                },
            })
        end,
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/neotest-python",
        },
        ft = "python",
        opts = function(_, opts)
            table.insert(
                opts.adapters,
                require("neotest-python")({
                    dap = {
                        console = "integratedTerminal",
                        justMyCode = false,
                    },
                    runner = "pytest",
                })
            )
        end,
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "mfussenegger/nvim-dap-python",
        },
        opts = function()
            -- Python adapter settings
            require("dap-python").setup(vim.fn.exepath("debugpy-adapter"))
        end,
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                python = { "ruff_organize_imports", "ruff_format" },
            },
        },
    },
}
