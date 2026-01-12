return {
    {
        "folke/which-key.nvim",
        opts = {
            spec = {
                { "<leader>l", group = "LSP", icon = "󰘦" },
                {
                    group = "LSP",
                    { "<leader>lh", function() vim.lsp.buf.hover() end, desc = "Hover", icon = "󰯗" },
                    { "<leader>lr", function() vim.lsp.buf.rename() end, desc = "Rename", icon = "" },
                    {
                        "<leader>la",
                        function() vim.lsp.buf.code_action() end,
                        desc = "Code Action",
                        icon = { icon = "", color = "yellow" },
                    },
                    {
                        "<leader>li",
                        function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 }) end,
                        desc = "Toggle LSP inlays",
                        icon = "",
                    },
                    {
                        "<leader>lc",
                        vim.lsp.codelens.run,
                        desc = "Run Codelens",
                        mode = { "n", "x" },
                        icon = { icon = "󱡴", color = "azure" },
                    },
                    {
                        "<leader>lC",
                        vim.lsp.codelens.refresh,
                        desc = "Refresh & Display Codelens",
                        mode = { "n" },
                        icon = { icon = "󱡴", color = "blue" },
                    },
                },
            },
            icons = {
                rules = {
                    { pattern = "Go to", icon = "" },
                    { pattern = "References", icon = "" },
                    { pattern = "Symbols", icon = "" },
                    { pattern = "Diagnostics", icon = "", color = "yellow" },
                },
            },
        },
    },
    {
        "folke/snacks.nvim",
        keys = {
            { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Go to Definition" },
            { "gi", function() Snacks.picker.lsp_implementations() end, desc = "Go to Implementation" },
            { "gt", function() Snacks.picker.lsp_type_definitions() end, desc = "Go to Type Definition" },
            { "<leader>lf", function() Snacks.picker.lsp_references() end, desc = "References" },
            { "<leader>ls", function() Snacks.picker.lsp_symbols() end, desc = "Symbols" },
            {
                "<leader>lS",
                function() Snacks.picker.lsp_symbols({ filter = { default = true } }) end,
                desc = "All Symbols",
            },
            { "<leader>lw", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Workspace symbols" },
            { "<leader>lc", function() Snacks.picker.lsp_incoming_calls() end, desc = "Incoming calls" },
            { "<leader>ld", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
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
            --- For LSP Capabilities
            --- See: https://cmp.saghen.dev/installation.html
            "saghen/blink.cmp",
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
                -- Python
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
        config = function()
            local lint = require("lint")
            lint.linters_by_ft = { text = { "vale" } } --clear the default
        end,
    },
}
