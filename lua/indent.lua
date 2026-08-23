return {
  reset = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = CS.indent_level
    vim.opt_local.tabstop = CS.indent_level
    vim.opt_local.softtabstop = CS.indent_level
  end,
}
