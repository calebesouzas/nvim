local function open_buflist()
  local buffers = vim.api.nvim_list_bufs()
  local paths = {}

  local should_select_buffer = function(bufnr)
    local loaded = vim.api.nvim_buf_is_loaded(bufnr)
    local isfile = vim.api.nvim_get_option_value("buftype", {buf = bufnr}) == ""
    return loaded and isfile
  end
  
  for _, bufnr in ipairs(buffers) do
    if should_select_buffer(bufnr) then
      local file_name = vim.api.nvim_buf_get_name(bufnr)
      if file_name ~= "" then
        local path = vim.fn.fnamemodify(file_name, ":.")
        table.insert(paths, path)
      end
    end
  end

  if #paths == 0 then
    print("No open paths at the moment!")
    return
  end

  -- 'false' para não listado, 'true' para scratch (esquecido ao fechar)
  local buf = vim.api.nvim_create_buf(false, true)

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, paths)

  -- Vamos abrir um split na direita com tamanho 40
  vim.cmd("split")
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, buf)
  vim.api.nvim_win_set_height(win, #paths)

  vim.api.nvim_set_option_value("number", false, { win = win })
  vim.api.nvim_set_option_value("relativenumber", false, { win = win })

  local opts = { buffer = buf, silent = true }
  vim.keymap.set("n", "<CR>", function()
    local current_line = vim.api.nvim_win_get_cursor(0)[1]
    local path_selected = paths[current_line]

    vim.api.nvim_win_close(win, true)

    if path_selected then
      vim.cmd("edit " .. vim.fn.fnameescape(path_selected))
    end
  end, opts)
  
  vim.keymap.set("n", "q", function()
    vim.api.nvim_win_close(win, true)
  end, opts)
end

vim.api.nvim_create_user_command("BufList", open_buflist, {})

vim.keymap.set("n", "<leader>bs", open_buflist, { desc = "Open Buffer List" })
