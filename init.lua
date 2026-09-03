local home = os.getenv("HOME")

vim.o.background = "dark"
vim.cmd("colorscheme catppuccin")

CS = {
  indent_level = 2
}

-- Keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local map = {
  n = function (key, command, opts)
    vim.keymap.set("n", key, command, opts or {})
  end,
}

map.n("<leader>w", ":w<CR>") -- i type ':W' almost all the time
map.n("<leader>sh", ":split<CR>")
map.n("<leader>sv", ":vsplit<CR>")
map.n("<leader>bp", ":bprev<CR>")
map.n("<leader>bn", ":bnext<CR>")
map.n("<leader>be", ":edit ")
map.n("<leader>i", ":Inspect<CR>")
map.n("<leader>ns", ":nohlsearch<CR>")
map.n("<leader>tc", ":tabnew<CR>")
map.n("<leader>tn", ":tabnext<CR>")
map.n("<leader>tp", ":tabprev<CR>")
map.n("<leader>tx", ":tabclose<CR>")
map.n("<leader>tf", ":tabfind ")
map.n("<leader>tm", ":tabmove ")
map.n("<leader>ff", ":FZF<CR>")

-- Line numbers
vim.o.number = true
-- vim.o.relativenumber = true

-- Indentation
vim.o.expandtab = true -- use spaces instead of '\t' character
vim.o.shiftwidth = CS.indent_level -- how many spaces >> and << shift
vim.o.tabstop = CS.indent_level -- how many spaces the Tab key inserts
vim.o.softtabstop = CS.indent_level -- don't really know what this one is

-- Scrolling
vim.o.scrolloff = 8 -- minimum lines below and above the cursor

-- Colors
vim.o.termguicolors = true

-- C coding specifics
vim.env.CC = "clang" -- we don't have real GCC on Termux. It is basically clang
vim.g.c_syntax_for_h = 1
