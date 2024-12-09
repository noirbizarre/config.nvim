return {
    --- 1Password integration
    --- https://github.com/mrjones2014/op.nvim
    {
        "mrjones2014/op.nvim",
        build = "make install",
        opts = {
            statusline_fmt = function(account_name)
                if not account_name or #account_name == 0 then
                    return "🔒"
                end

                return string.format("🔓 %s", account_name)
            end,
        },
    },
}
