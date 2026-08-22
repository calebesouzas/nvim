return {
  reset = function()
    vim.bo.expandtab = true
    vim.bo.shiftwidth = CS.indent_level
    vim.bo.tabstop = CS.indent_level
    vim.bo.softtabstop = CS.indent_level
  end,
}
