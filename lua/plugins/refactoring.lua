return {
    --- The Refactoring library based off the Refactoring book by Martin Fowler
    --- https://github.com/ThePrimeagen/refactoring.nvim
    {
        "ThePrimeagen/refactoring.nvim",
        keys = {
            {
                "<leader>rp",
                function()
                    require("refactoring").debug.printf({})
                end,
                desc = "Print statement",
            },
            {
                "<leader>rd",
                function()
                    require("refactoring").debug.print_var({})
                end,
                mode = { "n", "x" },
                desc = "Print var statement",
            },
            {
                "<leader>rc",
                function()
                    require("refactoring").debug.cleanup({})
                end,
                desc = "Clear print statements",
            },
            -- Telescope menu
            {
                "<leader>kr",
                function()
                    require("telescope").extensions.refactoring.refactors()
                end,
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
    },
    --- Comments
    --- https://github.com/numToStr/Comment.nvim
    {
        "numToStr/Comment.nvim",
        lazy = false,
        config = true,
    },
    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-move.md
    {
        "echasnovski/mini.move",
        version = false,
        config = true,
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
                function()
                    require("conform").format({ async = true })
                end,
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
        keys = {
            { "<leader>ss", '<cmd>:lua require("grug-far").open({ transient = true })<CR>', desc = "Search & replace" },
            {
                "<leader>S",
                '<cmd>:lua require("grug-far").toggle_instance({ instanceName="far", staticTitle="Find and Replace" })<CR>',
                desc = "Toggle Grug-Far",
            },
            {
                "<leader>sw",
                '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
                desc = "Search current word",
            },
            { "<leader>sw", '<cmd>lua require("spectre").open_visual()<CR>', mode = "v", desc = "Search current word" },
            {
                "<leader>sp",
                '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
                desc = "Search on current file",
            },
        },
        opts = { headerMaxWidth = 100 },
    },
    --- Multicursor support
    --- https://github.com/jake-stewart/multicursor.nvim
    {
        "jake-stewart/multicursor.nvim",
        branch = "1.0",
    },
}
