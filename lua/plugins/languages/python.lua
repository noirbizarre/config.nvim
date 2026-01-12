vim.filetype.add({
    extension = {
        -- Textual custom CSS (https://textual.textualize.io/guide/CSS/)
        -- switch https://github.com/cachebag/nvim-tcss if not enough
        tcss = "css",
    },
})

return {
    {
        "noirbizarre/ensure.nvim",
        opts = {
            packages = { python = "debugpy" },
            parsers = {
                "pymanifest",
                "python",
            },
            formatters = {
                python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
            },
            lsp = {
                enable = {
                    -- "basedpyright",
                    "ruff",
                    "ty",
                    "pytest_lsp",
                },
                ty = {
                    settings = {
                        ty = {
                            diagnosticMode = "workspace",
                        },
                    },
                },
                basedpyright = {
                    settings = {
                        basedpyright = {
                            analysis = {
                                autoImportCompletions = true,
                                -- diagnosticMode = "workspace",
                                typeCheckingMode = "standard",
                            },
                        },
                    },
                },
                pytest_lsp = {
                    cmd = { "pytest-language-server" },
                    filetypes = { "python" },
                    root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "pytest.ini", ".git" },
                },
            },
        },
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
}
