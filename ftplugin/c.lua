-- vim.treesitter.start()

vim.keymap.set("n", "<leader>ch", function()
  local raw_header_name = vim.fn.input("Header name: ")
  local header_name = raw_header_name
  vim.api.nvim_put({
    "#ifndef " .. header_name,
    "#define " .. header_name,
    "",
    "#endif /* " .. header_name .. " */",
  }, "l", false, false)
end, { buffer = 0 })

vim.keymap.set("n", "<leader>cf", function()
  local root = vim.fs.root(0, ".git")
  if root == nil then
    vim.notify("Couldn't find project root...", vim.log.levels.ERROR)
    return
  end

  local file = vim.fn.input("File name: ")
  if file == "~" then
    return
  end
end)
