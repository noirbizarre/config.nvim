return { -- snippets
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        opts = {
            history = true,
            delete_check_events = "TextChanged"
        },
        -- stylua: ignore
        keys = {
            {
                "<tab>",
                function()
                    return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
                end,
                expr = true,
                silent = true,
                mode = "i"
            },
            {
                "<tab>",
                function()
                    require("luasnip").jump(1)
                end,
                mode = "s"
            },
            {
                "<s-tab>",
                function()
                    require("luasnip").jump(-1)
                end,
                mode = {"i", "s"}
            },
        },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    }, 
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", 
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-emoji", 
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "onsails/lspkind.nvim",
        },
        event = "InsertEnter",
        ---@param opts cmp.ConfigSchema
        opts = function()
            local cmp = require("cmp")
	        local lspkind = require("lspkind")
            local luasnip = require('luasnip')
            local icons = require("config.ui").icons

            return {
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },          
                sources = {
                    { name = "nvim_lsp" },
                    { name = "path" },
                    { name = "luasnip" },
                    { name = "buffer", keyword_length = 3 },
                    { name = "emoji" },
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol_text",
                        maxwidth = 50,
                        ellipsis_char = '…',
                        symbol_map = icons.kinds,
                    }),
                },
            }
        end
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    }
}
