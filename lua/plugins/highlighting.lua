return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        cmd = { "TSInstall", "TSUpdate", "TSInstallInfo", "TSBufEnable", "TSBufDisable","TSEnable", "TSDisable", "TSInstallInfo", },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "bash",
                    "c",
                    "cmake",
                    -- "comment", -- comments are slowing down TS bigtime, so disable for now
                    "cpp",
                    "css",
                    "diff",
                    "dockerfile",
                    "fish",
                    "gitattributes",
                    "gitignore",
                    "go",
                    "graphql",
                    "help",
                    "html",
                    "http",
                    "java",
                    "javascript",
                    "jsdoc",
                    "jsonc",
                    "kdl",
                    "latex",
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "mermaid",
                    "meson",
                    "ninja",
                    "nix",
                    "norg",
                    "org",
                    "php",
                    "python",
                    "prisma",
                    "proto",
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
                    -- "terraform",
                    "toml",
                    "tsx",
                    "typescript",
                    "vhs",
                    "vim",
                    "vue",
                    "yaml",
                    -- "wgsl",
                    "json",
                    -- "markdown",
                },
                 -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = true,

                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },

    --- Highlight other uses of the word under the cursor 
    --- https://github.com/RRethy/vim-illuminate
    {
        "RRethy/vim-illuminate",
        config = function()
            require('illuminate').configure({
                -- -- providers: provider used to get references in the buffer, ordered by priority
                -- providers = {
                --     'lsp',
                --     'treesitter',
                --     'regex',
                -- },
                -- -- delay: delay in milliseconds
                -- delay = 100,
                -- -- filetype_overrides: filetype specific overrides.
                -- -- The keys are strings to represent the filetype while the values are tables that
                -- -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
                -- filetype_overrides = {},
                -- -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
                -- filetypes_denylist = {
                --     'dirvish',
                --     'fugitive',
                -- },
                -- -- filetypes_allowlist: filetypes to illuminate, this is overriden by filetypes_denylist
                -- filetypes_allowlist = {},
                -- -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
                -- -- See `:help mode()` for possible values
                -- modes_denylist = {},
                -- -- modes_allowlist: modes to illuminate, this is overriden by modes_denylist
                -- -- See `:help mode()` for possible values
                -- modes_allowlist = {},
                -- -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
                -- -- Only applies to the 'regex' provider
                -- -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
                -- providers_regex_syntax_denylist = {},
                -- -- providers_regex_syntax_allowlist: syntax to illuminate, this is overriden by providers_regex_syntax_denylist
                -- -- Only applies to the 'regex' provider
                -- -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
                -- providers_regex_syntax_allowlist = {},
                -- -- under_cursor: whether or not to illuminate under the cursor
                -- under_cursor = true,
                -- -- large_file_cutoff: number of lines at which to use large_file_config
                -- -- The `under_cursor` option is disabled when this cutoff is hit
                -- large_file_cutoff = nil,
                -- -- large_file_config: config to use for large files (based on large_file_cutoff).
                -- -- Supports the same keys passed to .configure
                -- -- If nil, vim-illuminate will be disabled for large files.
                -- large_file_overrides = nil,
                -- -- min_count_to_highlight: minimum number of matches required to perform highlighting
                -- min_count_to_highlight = 1,
            })
        end,
    },
    -- https://github.com/lukas-reineke/indent-blankline.nvim
    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        event = { 'BufReadPost', 'BufNewFile' },
        opts = {
            indent = { char = '│', tab_char = '│' },
            scope = { enabled = false },
            exclude = { filetypes = { 'lazy', 'dashboard', 'mason' } },
        },
    },

    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = { "TodoTrouble", "TodoTelescope" },
        -- event = "LazyFile",
        config = true,
        -- stylua: ignore
        keys = {
            { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
            { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
            { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
            { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
            { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
            { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
        },
    },
    -- Jinja
    -- {
    --     "HiPhish/jinja.vim",
    -- },

    -- colorizer
    {
        "NvChad/nvim-colorizer.lua",
        event = "BufReadPre",
        config = {
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
}
