--- Use Snacks debug tooling
_G.dd = function(...) require("snacks.debug").inspect(...) end
_G.bt = function(...) require("snacks.debug").backtrace() end
_G.p = function(...) require("snacks.debug").profile(...) end
vim.print = _G.dd
