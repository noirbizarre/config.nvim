vim.filetype.add {
  extension = {
    jinja = 'jinja',
    jinja2 = 'jinja',
    j2 = 'jinja',
  },
  pattern = {
    -- [".*%.github/workflows/.*%.yml"] = "yaml.ghaction",
    -- [".*%.github/workflows/.*%.yaml"] = "yaml.ghaction",
  },
}

vim.treesitter.language.register('properties', { 'jproperties' })
