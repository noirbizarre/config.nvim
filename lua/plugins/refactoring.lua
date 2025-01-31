return {
    --- The Refactoring library based off the Refactoring book by Martin Fowler
    --- https://github.com/ThePrimeagen/refactoring.nvim
    {
        "ThePrimeagen/refactoring.nvim",
        keys = {
            {
                "<leader>rp",
                function() require("refactoring").debug.printf({}) end,
                desc = "Print statement",
            },
            {
                "<leader>rd",
                function() require("refactoring").debug.print_var({}) end,
                mode = { "n", "x" },
                desc = "Print var statement",
            },
            {
                "<leader>rc",
                function() require("refactoring").debug.cleanup({}) end,
                desc = "Clear print statements",
            },
            -- Telescope menu
            {
                "<leader>kr",
                function() require("telescope").extensions.refactoring.refactors() end,
                mode = { "n", "x" },
                desc = "Refactor",
            },
        },
        opts = {
            printf_statements = {
                python = { 'print(f"🔎 [%s]=> {locals()=}")' },
            },
            print_var_statements = {
                python = { 'print(f"🔎 %.0s{%s=}")' },
            },
        },
        init = function() require("telescope").load_extension("refactoring") end,
    },
    --- Comments
    --- https://github.com/numToStr/Comment.nvim
    {
        "numToStr/Comment.nvim",
        lazy = false,
        config = true,
    },
    --- Codedocs - Generate docstrings
    {
        "jeangiraldoo/codedocs.nvim",
        cmd = "Codedocs",
        keys = {
            {
                "<leader>rh",
                function() require("codedocs").insert_docs() end,
                desc = "Insert a docstring",
            },
        },
        opts = {
            default_styles = { python = "reST" },
        },
    },
    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-move.md
    {
        "echasnovski/mini.move",
        version = false,
        config = true,
        opts = {
            mappings = {
                -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
                left = "<M-H>",
                right = "<M-L>",
                down = "<M-J>",
                up = "<M-K>",
                -- Move current line in Normal mode
                line_left = "<M-H>",
                line_right = "<M-L>",
                line_down = "<M-J>",
                line_up = "<M-K>",
            },
        },
    },
    -- Format
    -- https://github.com/stevearc/conform.nvim
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        cmd = { "ConformInfo" },
        keys = {
            {
                "<leader>rf",
                function() require("conform").format({ async = true }) end,
                desc = "Format buffer",
            },
        },
        opts = {
            formatters_by_ft = {
                css = { "prettier" },
                graphql = { "prettier" },
                html = { "prettier" },
                javascript = { "prettier" },
                javascriptreact = { "prettier" },
                json = { "prettier" },
                lua = { "stylua" },
                markdown = { "prettier" },
                python = { "ruff_organize_imports", "ruff_format" },
                rust = { "rustfmt" },
                sh = { "shfmt" },
                svelte = { "prettier" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },
                yaml = { "prettier" },
                ["*"] = { "codespell" },
            },
            notify_on_error = true,
        },
    },
    --- https://github.com/zapling/mason-conform.nvim
    {
        "zapling/mason-conform.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "stevearc/conform.nvim",
        },
        config = true,
    },
    --- Global search and replace
    --- https://github.com/MagicDuck/grug-far.nvim
    {
        "MagicDuck/grug-far.nvim",
        cmd = "GrugFar",
        keys = {
            {
                "<leader>ss",
                function() require("grug-far").open({ transient = true }) end,
                mode = { "n", "v" },
                desc = "Search & replace",
            },
            {
                "<leader>S",
                function()
                    require("grug-far").toggle_instance({ instanceName = "far", staticTitle = "Find and Replace" })
                end,
                mode = { "n", "v" },
                desc = "Toggle Grug-Far",
            },
            {
                "<leader>sw",
                function()
                    require("grug-far").open({
                        prefills = {
                            search = vim.fn.expand("<cword>"),
                        },
                    })
                end,
                desc = "Search current word",
            },
        },
        opts = { headerMaxWidth = 100 },
    },
    --- Multicursor support
    --- https://github.com/jake-stewart/multicursor.nvim
    {
        "jake-stewart/multicursor.nvim",
        branch = "1.0",
        keys = function()
            local mc = require("multicursor-nvim")
            return {
                {
                    "<leader>Mn",
                    function() mc.matchAddCursor(1) end,
                    mode = { "n", "v" },
                    desc = "Add next match",
                },
                {
                    "<leader>Ms",
                    function() mc.matchSkipCursor(1) end,
                    mode = { "n", "v" },
                    desc = "Skip next match",
                },
                {
                    "<leader>MN",
                    function() mc.matchAddCursor(-1) end,
                    mode = { "n", "v" },
                    desc = "Add previous match",
                },
                {
                    "<leader>MS",
                    function() mc.matchSkipCursor(-1) end,
                    mode = { "n", "v" },
                    desc = "Skip next match",
                },
                { "<leader>MA", mc.matchAllAddCursors, mode = { "n", "v" }, desc = "Add all matches" },
                { "<c-leftmouse>", mc.handleMouse, desc = "Add/Remove cursor with mouse" },
                { "<leader>Mi", mc.insertVisual, mode = { "v" }, desc = "Insert cursor to each line of selection" },
                { "<leader>Ma", mc.appendVisual, mode = { "v" }, desc = "Append cursor to each line of selection" },
                { "<leader>MM", mc.matchCursors, mode = { "v" }, desc = "Match new cursors within selection by regex" },
                { "<leader>Mx", mc.clearCursors, desc = "Clear cursors" },
            }
        end,
        config = function() require("multicursor-nvim").setup() end,
    },
}
