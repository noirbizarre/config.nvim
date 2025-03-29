local basename = vim.fn.expand("%:t")
for _, ext in ipairs({ "jinja", "jinja2", "j2" }) do
    basename = basename:gsub("%." .. ext, "")
end

local ft = vim.filetype.match({ filename = basename })
if ft ~= nil then
    vim.bo.filetype = ft .. ".jinja"
else
    vim.bo.filetype = "jinja"
end
