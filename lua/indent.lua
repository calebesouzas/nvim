local M = {}

local function reset()
  vim.bo.expandtab = true
  vim.bo.shiftwidth = CalebeSouzas.indent_level
  vim.bo.tabstop = CalebeSouzas.indent_level
  vim.bo.softtabstop = CalebeSouzas.indent_level
end

table.insert(M, reset)

return M
