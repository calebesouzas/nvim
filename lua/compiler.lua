return {
  setup = function()
    vim.cmd("set makeef=errors.txt")

    vim.keymap.set("n", "<leader>cc", function() vim.cmd("make") end)
    vim.keymap.set("n", "<leader>cn", function() vim.cmd("cnext") end)
    vim.keymap.set("n", "<leader>cp", function() vim.cmd("cprevious") end)
  end
}
