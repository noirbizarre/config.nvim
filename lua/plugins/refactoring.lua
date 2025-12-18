return {
    --- The Refactoring library based off the Refactoring book by Martin Fowler
    {
        "ThePrimeagen/refactoring.nvim",
        keys = {
            {
                "<leader>rr",
                function() require("refactoring").select_refactor({ prefer_ex_cmd = true }) end,
                mode = { "n", "x" },
                desc = "Refactor",
            },
        },
    },
    --- Comments
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
            default_styles = {
                { python = "Google" },
            },
            styles = {
                python = {
                    Google = {
                        func = {
                            params = {
                                include_type = false,
                            },
                            return_type = {
                                include_type = false,
                            },
                        },
                    },
                },
            },
        },
    },
    -- Move selection
    {
        "nvim-mini/mini.move",
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
                ["*"] = { "codespell" },
            },
            notify_on_error = true,
        },
    },
    -- --- Install formatters
    -- {
    --     "zapling/mason-conform.nvim",
    --     dependencies = {
    --         "mason-org/mason.nvim",
    --         "stevearc/conform.nvim",
    --     },
    --     config = true,
    -- },
    --- Global search and replace
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
    {
        "jake-stewart/multicursor.nvim",
        branch = "1.0",
        keys = function()
            local mc = require("multicursor-nvim")
            return {
                {
                    "<leader>\\n",
                    function() mc.matchAddCursor(1) end,
                    mode = { "n", "v" },
                    desc = "Add next match",
                },
                {
                    "<leader>\\s",
                    function() mc.matchSkipCursor(1) end,
                    mode = { "n", "v" },
                    desc = "Skip next match",
                },
                {
                    "<leader>\\N",
                    function() mc.matchAddCursor(-1) end,
                    mode = { "n", "v" },
                    desc = "Add previous match",
                },
                {
                    "<leader>\\S",
                    function() mc.matchSkipCursor(-1) end,
                    mode = { "n", "v" },
                    desc = "Skip next match",
                },
                { "<leader>\\A", mc.matchAllAddCursors, mode = { "n", "v" }, desc = "Add all matches" },
                { "<c-leftmouse>", mc.handleMouse, desc = "Add/Remove cursor with mouse" },
                { "<leader>\\i", mc.insertVisual, mode = { "v" }, desc = "Insert cursor to each line of selection" },
                { "<leader>\\a", mc.appendVisual, mode = { "v" }, desc = "Append cursor to each line of selection" },
                {
                    "<leader>\\M",
                    mc.matchCursors,
                    mode = { "v" },
                    desc = "Match new cursors within selection by regex",
                },
                { "<leader>\\x", mc.clearCursors, desc = "Clear cursors" },
                -- Add and remove cursors with control + left click.
                { "<c-leftmouse>", mc.handleMouse, desc = "Add/Remove cursor with mouse" },
                { "<c-leftdrag>", mc.handleMouseDrag, desc = "Drag to add cursors" },
                { "<c-leftrelease>", mc.handleMouseRelease, desc = "Release mouse to add cursors" },
                -- Operators
                -- { "gm", mc.addCursorOperator, desc = "Multicursor motion operator" },
                -- { "g\\", mc.operator, desc = "Multicursor operator" },
            }
        end,
        config = function()
            local mc = require("multicursor-nvim")
            mc.setup()

            -- Mappings defined in a keymap layer only apply when there are
            -- multiple cursors. This lets you have overlapping mappings.
            mc.addKeymapLayer(function(layerSet)
                -- Select a different cursor as the main one.
                layerSet({ "n", "x" }, "<left>", mc.prevCursor)
                layerSet({ "n", "x" }, "<right>", mc.nextCursor)

                -- Delete the main cursor.
                layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)

                -- Enable and clear cursors using escape.
                layerSet("n", "<esc>", function()
                    if not mc.cursorsEnabled() then
                        mc.enableCursors()
                    else
                        mc.clearCursors()
                    end
                end)
            end)
        end,
    },
    --- Add live visual selection to multicursor
    {
        "zaucy/mcos.nvim",
        dependencies = {
            "jake-stewart/multicursor.nvim",
        },
        keys = {
            {
                "<leader>\\v",
                function() require("mcos").bufkeymapfunc() end,
                mode = { "n", "v" },
                desc = "Multicursor Visual Selection",
            },
        },
        opts = {},
    },
}
