return {
    {
        "nvim-neotest/neotest",
        ft = "go",
        dependencies = {
            "nvim-neotest/neotest-go",
        },
        opts = function(_, opts) table.insert(opts.adapters, require("neotest-go")) end,
    },
}
