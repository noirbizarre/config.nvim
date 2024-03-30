return {
    {
        "nvim-treesitter/nvim-treesitter",
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
                -- indent = { enable = false },
                -- context_commentstring = { enable = true, enable_autocmd = false },
                -- incremental_selection = {
                --     enable = true,
                --     keymaps = {
                --         init_selection = "<C-space>",
                --         node_incremental = "<C-space>",
                --         scope_incremental = "<C-s>",
                --         node_decremental = "<C-bs>",
                --     },
                -- },
                -- query_linter = {
                --     enable = true,
                --     use_virtual_text = true,
                --     lint_events = { "BufWrite", "CursorHold" },
                -- },
                -- playground = {
                --     enable = true,
                --     disable = {},
                --     updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                --     persist_queries = true, -- Whether the query persists across vim sessions
                --     keybindings = {
                --         toggle_query_editor = "o",
                --         toggle_hl_groups = "i",
                --         toggle_injected_languages = "t",
                --         toggle_anonymous_nodes = "a",
                --         toggle_language_display = "I",
                --         focus_language = "f",
                --         unfocus_language = "F",
                --         update = "R",
                --         goto_node = "<cr>",
                --         show_help = "?",
                --     },
                -- },
                -- textobjects = {
                --     select = {
                --         enable = false,
                --     },
                --     move = {
                --         enable = false,
                --     },
                --     lsp_interop = {
                --         enable = false,
                --     },
                -- },
            })
        end,
    },

    --- Highlight other uses of the word under the cursor 
    --- https://github.com/RRethy/vim-illuminate
    {
        "RRethy/vim-illuminate",
        config = true,
    --     require('illuminate').configure({
    --         -- providers: provider used to get references in the buffer, ordered by priority
    --         providers = {
    --             'lsp',
    --             'treesitter',
    --             'regex',
    --         },
    --         -- delay: delay in milliseconds
    --         delay = 100,
    --         -- filetype_overrides: filetype specific overrides.
    --         -- The keys are strings to represent the filetype while the values are tables that
    --         -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
    --         filetype_overrides = {},
    --         -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
    --         filetypes_denylist = {
    --             'dirvish',
    --             'fugitive',
    --         },
    --         -- filetypes_allowlist: filetypes to illuminate, this is overriden by filetypes_denylist
    --         filetypes_allowlist = {},
    --         -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
    --         -- See `:help mode()` for possible values
    --         modes_denylist = {},
    --         -- modes_allowlist: modes to illuminate, this is overriden by modes_denylist
    --         -- See `:help mode()` for possible values
    --         modes_allowlist = {},
    --         -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
    --         -- Only applies to the 'regex' provider
    --         -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    --         providers_regex_syntax_denylist = {},
    --         -- providers_regex_syntax_allowlist: syntax to illuminate, this is overriden by providers_regex_syntax_denylist
    --         -- Only applies to the 'regex' provider
    --         -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    --         providers_regex_syntax_allowlist = {},
    --         -- under_cursor: whether or not to illuminate under the cursor
    --         under_cursor = true,
    --         -- large_file_cutoff: number of lines at which to use large_file_config
    --         -- The `under_cursor` option is disabled when this cutoff is hit
    --         large_file_cutoff = nil,
    --         -- large_file_config: config to use for large files (based on large_file_cutoff).
    --         -- Supports the same keys passed to .configure
    --         -- If nil, vim-illuminate will be disabled for large files.
    --         large_file_overrides = nil,
    --         -- min_count_to_highlight: minimum number of matches required to perform highlighting
    --         min_count_to_highlight = 1,
    --     }),
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
}
