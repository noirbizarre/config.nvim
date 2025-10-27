local ts_parsers = {
    "bash",
    "c",
    "cmake",
    "comment",
    "cpp",
    "css",
    "csv",
    "desktop",
    "diff",
    "dockerfile",
    "dot",
    "doxygen",
    "editorconfig",
    "fish",
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "go",
    "gomod",
    "gosum",
    "gotmpl",
    "gpg",
    "graphql",
    "hcl",
    "helm",
    "html",
    "hyprlang",
    "http",
    "ini",
    "java",
    "javascript",
    "jinja",
    "jinja_inline",
    "jq",
    "jsdoc",
    "json",
    "json5",
    "jsonc",
    "just",
    "kdl",
    "latex",
    "lua",
    "luadoc",
    "make",
    "markdown",
    "markdown_inline",
    "mermaid",
    "meson",
    "ninja",
    "nix",
    "norg",
    "php",
    "po",
    "printf",
    "prisma",
    "proto",
    "properties",
    "pymanifest",
    "python",
    "query",
    "regex",
    "rst",
    "rust",
    "scala",
    "scss",
    "sql",
    "svelte",
    "terraform",
    "toml",
    "tsx",
    "tmux",
    "typescript",
    "udev",
    "vim",
    "vue",
    "yaml",
}

vim.api.nvim_create_autocmd("FileType", {
    desc = "Enable Treesitter",
    group = vim.api.nvim_create_augroup("enable_treesitter", {}),
    -- Don't filter by `pattern`, install and enable Treesitter parsers for all languages.
    callback = function()
        -- Enable Treesitter syntax highlighting.
        if pcall(vim.treesitter.start) then
            -- Use Treesitter indentation and folds.
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            vim.wo.foldmethod = "expr"
            vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        end
    end,
})

return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        branch = "main",
        build = function()
            require("nvim-treesitter").install(ts_parsers)
            require("nvim-treesitter").update()
        end,
    },
    -- Incremental selection
    {
        "MeanderingProgrammer/treesitter-modules.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<Enter>",
                    node_incremental = "<Enter>",
                    scope_incremental = false,
                    node_decremental = "<BS>",
                },
            },
        },
    },
    -- Custom Textobjects
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        keys = function()
            local keys = {
                --- Swaps
                {
                    "<leader>rsp",
                    function() require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner") end,
                    desc = "Swap with next parameter",
                },
                {
                    "<leader>rsP",
                    function() require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner") end,
                    desc = "Swap with previous parameter",
                },
            }

            local selects = {
                { "af", "@function.outer" },
                { "if", "@function.inner" },
                { "ac", "@class.outer" },
                { "ic", "@class.inner" },
                { "ap", "@parameter.outer" },
                { "ip", "@parameter.inner" },
                { "al", "@loop.outer" },
                { "il", "@loop.inner" },
                { "ab", "@block.outer" },
                { "ib", "@block.inner" },
                { "as", "@local.scope" },
            }
            for _, obj in ipairs(selects) do
                keys[#keys + 1] = {
                    obj[1],
                    function() require("nvim-treesitter-textobjects.select").select_textobject(obj[2], "textobjects") end,
                    mode = { "x", "o" },
                    desc = obj[2],
                }
            end

            return keys
        end,
        opts = {
            select = {
                enable = true,
                lookahead = true,
                selection_modes = {
                    ["@parameter.outer"] = "v", -- charwise
                    ["@function.outer"] = "V", -- linewise
                    ["@class.outer"] = "<c-v>", -- blockwise
                },
            },
        },
    },

    -- Adjust indent with treesitter injections
    {
        "wurli/contextindent.nvim",
        -- This is the only config option; you can use it to restrict the files
        -- which this plugin will affect (see :help autocommand-pattern).
        opts = { pattern = "*.md" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    --- Display current code context as sticky header
    {
        "nvim-treesitter/nvim-treesitter-context",
        opts = {
            mode = "topline",
            multiline_threshold = 5,
        },
    },

    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = { "TodoTrouble" },
        lazy = false,
        config = true,
        -- stylua: ignore
        keys = {
            { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
            { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
            { "<leader>kt", function() Snacks.picker.todo_comments() end, desc = "TODOs" },
            { "<leader>kT", function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
        },
    },
    {
        "eero-lehtinen/oklch-color-picker.nvim",
        event = "VeryLazy",
        keys = {
            -- One handed keymap recommended, you will be using the mouse
            {
                "<leader>uc",
                function() require("oklch-color-picker").pick_under_cursor() end,
                desc = "Color pick under cursor",
            },
        },
        ---@type oklch.Opts
        opts = {},
    },
    {
        "rachartier/tiny-glimmer.nvim",
        event = "VeryLazy",
        opts = {
            -- your configuration
        },
    },
}
