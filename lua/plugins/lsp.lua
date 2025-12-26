return {
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
            {
                "cenk1cenk2/schema-companion.nvim",
                -- dev = true,
                dependencies = {
                    { "nvim-lua/plenary.nvim" },
                },
                opts = {},
            },
            --- For LSP Cpabilities
            --- See: https://cmp.saghen.dev/installation.html
            "saghen/blink.cmp",
        },
        keys = {
            {
                "<leader>ks",
                function() require("schema-companion").select_matching_schema() end,
                desc = "Select a matching Schema",
            },
            { "<leader>kS", function() require("schema-companion").select_schema() end, desc = "Select any Schema" },
        },

        config = function()
            -- Force file watching support even on backends that do not
            -- See:
            --  - https://github.com/neovim/neovim/issues/23291
            --  - https://github.com/neovim/neovim/pull/28690
            local original_make_capabilities = vim.lsp.protocol.make_client_capabilities
            vim.lsp.protocol.make_client_capabilities = function()
                local capabilities = original_make_capabilities()
                capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
                return capabilities
            end

            local icons = require("lib.ui.icons")

            -- Exclude big directories from being watched
            vim.lsp._watchfiles._poll_exclude_pattern = vim.lsp._watchfiles._poll_exclude_pattern
                -- Standard cache dirs
                + vim.glob.to_lpeg("**/.*_cache/**")
                -- Virtualenv (Need LSP restart)
                -- + vim.glob.to_lpeg("**/.venv/**")
                + vim.glob.to_lpeg("**/.tox/**")
                + vim.glob.to_lpeg("**/__pycache__/**")
                -- JS/TS
                + vim.glob.to_lpeg("**/.yarn/**")
                -- rust build assets
                + vim.glob.to_lpeg("**/target/**")
                + vim.glob.to_lpeg("**/build/**")
                + vim.glob.to_lpeg("**/dist/**")

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
        opts = {
            linters_by_ft = {
                text = { "vale" },
            },
        },
        config = function(_, opts)
            local lint = require("lint")
            for ft, linters in pairs(opts.linters_by_ft) do
                lint.linters_by_ft[ft] = linters
            end
        end,
    },
}
