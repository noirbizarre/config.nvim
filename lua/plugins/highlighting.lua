local filetypes = require("lib.filetypes")

return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        cmd = {
            "TSInstall",
            "TSUpdate",
            "TSInstallInfo",
            "TSBufEnable",
            "TSBufDisable",
            "TSEnable",
            "TSDisable",
            "TSInstallInfo",
        },
        -- TODO: remove for 1.0 👇
        main = "nvim-treesitter.configs",
        opts = {
            ensure_installed = {
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
                -- "help",
                "html",
                "http",
                "ini",
                "java",
                "javascript",
                "jq",
                "jsdoc",
                "json",
                "json5",
                "jsonc",
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
                "org",
                "php",
                "po",
                "printf",
                "prisma",
                "proto",
                "pymanifest",
                "python",
                "query",
                "regex",
                "rst",
                "rust",
                "scala",
                "scss",
                "solidity",
                "sql",
                "svelte",
                "teal",
                "terraform",
                "toml",
                "tsx",
                "typescript",
                "udev",
                "vhs",
                "vim",
                "vue",
                "yaml",
            },
            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = true,

            highlight = { enable = true },
            indent = { enable = true },
        },
    },

    -- Adjust indent with treesitter injections
    {
        "wurli/contextindent.nvim",
        -- This is the only config option; you can use it to restrict the files
        -- which this plugin will affect (see :help autocommand-pattern).
        opts = { pattern = "*" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    --- Display current code context as sticky header
    {
        "nvim-treesitter/nvim-treesitter-context",
        opts = {
            mode = "topline",
        },
    },

    -- https://github.com/folke/todo-comments.nvim
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = { "TodoTrouble", "TodoTelescope" },
        lazy = false,
        config = true,
        -- stylua: ignore
        keys = {
            { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
            { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
            { "<leader>kt", function() Snacks.picker.todo_comments() end, desc = "TODOs" },
            { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
            { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
        },
    },
    -- Jinja
    {
        "HiPhish/jinja.vim",
    },

    -- colorizer
    {
        "catgoose/nvim-colorizer.lua",
        event = "BufReadPre",
        opts = {
            filetypes = { "*", "!lazy" },
            buftype = { "*", "!prompt", "!nofile" },
            user_default_options = {
                RGB = true, -- #RGB hex codes
                RRGGBB = true, -- #RRGGBB hex codes
                names = false, -- "Name" codes like Blue
                RRGGBBAA = true, -- #RRGGBBAA hex codes
                AARRGGBB = false, -- 0xAARRGGBB hex codes
                rgb_fn = true, -- CSS rgb() and rgba() functions
                hsl_fn = true, -- CSS hsl() and hsla() functions
                css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
                -- Available modes: foreground, background,  virtualtext
                mode = "background", -- Set the display mode.
                virtualtext = "■",
                tailwind = true, -- Enable tailwind colors
            },
        },
    },
    {
        "rachartier/tiny-glimmer.nvim",
        event = "VeryLazy",
        opts = {
            -- your configuration
        },
    },
}
