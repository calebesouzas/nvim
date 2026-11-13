--[[
function! BreakHabitsWindow() abort
    " Define the size of the floating window
    let width = 50
    let height = 10

    " Create the scratch buffer displayed in the floating window
    let buf = nvim_create_buf(v:false, v:true)

    " Get the current UI
    let ui = nvim_list_uis()[0]

    " Create the floating window
    let opts = {'relative': 'editor',
                \ 'width': width,
                \ 'height': height,
                \ 'col': (ui.width/2) - (width/2),
                \ 'row': (ui.height/2) - (height/2),
                \ 'anchor': 'NW',
                \ 'style': 'minimal',
                \ }
    let win = nvim_open_win(buf, 1, opts)
endfunction
]]

local function open_buflist()
  local buffers = vim.api.nvim_list_bufs()
  local paths = {}

  local should_select_buffer = function(bufnr)
    local loaded = vim.api.nvim_buf_is_loaded(bufnr)
    local isfile = vim.api.nvim_get_option_value("buftype", {buf = bufnr}) == ""
    return loaded and isfile
  end

  local highest_len = 0
  for _, bufnr in ipairs(buffers) do
    if should_select_buffer(bufnr) then
      local file_name = vim.api.nvim_buf_get_name(bufnr)
      if file_name ~= "" then
        local path = vim.fn.fnamemodify(file_name, ":.")
        if highest_len < #path then
          highest_len = #path
        end
        table.insert(paths, path)
      end
    end
  end

  if #paths == 0 then
    print("No open paths at the moment!")
    return
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, paths)

  local width = highest_len
  local height = #paths

  local ui = vim.api.nvim_list_uis()[1]

  local win_opts = {
    relative = "editor",
    width = width,
    height = height,
    col = ui.width / 2 - width / 2,
    row = ui.height / 2 - height / 2,
    style = "minimal"
  }

  local win = vim.api.nvim_open_win(buf, 1, win_opts)

  vim.api.nvim_set_option_value("number", true, { win = win })

  local keymap_opts = { buffer = buf, silent = true }
  vim.keymap.set("n", "<CR>", function()
    local current_line = vim.api.nvim_win_get_cursor(0)[1]
    local path_selected = paths[current_line]

    vim.api.nvim_win_close(win, true)

    if path_selected then
      vim.cmd("edit " .. vim.fn.fnameescape(path_selected))
    end
  end, keymap_opts)

  vim.keymap.set("n", "q", function()
    vim.api.nvim_win_close(win, true)
  end, keymap_opts)
end

vim.api.nvim_create_user_command("BufList", open_buflist, {})

vim.keymap.set("n", "<leader>bs", open_buflist, { desc = "Open Buffer List" })

function toggle_buffer_number()
  vim.wo.number = not vim.wo.number
end

vim.keymap.set("n", "<leader>nr", toggle_buffer_number, { desc = "Toggle 'buffer_opt.number'" })
