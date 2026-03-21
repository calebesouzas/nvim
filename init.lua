local enable_relax = true -- my custom colorscheme for Neovim (made with lush)
-- local use_relax = true -- this is to really turn on the theme
local function lazy_plugins()
  return {
    -- I want to make a good custom color scheme but TreeSitter is not helping!
    -- {
    --   "nvim-treesitter/nvim-treesitter",
    --   build = ":TSUpdate",
    --   config = function()
    --     require("nvim-treesitter").setup({
    --       highlight = {
    --         enable = true,
    --         additional_vim_regex_highlighting = true,
    --       },
    --       indent = { enable = true },
    --     })
    --   end
    -- },
    {
      "rktjmp/lush.nvim",
      { dir = os.getenv("HOME") .. "/dev/nvim/relax" },
      enabled = enable_relax,
    },
    {
      dir = os.getenv("HOME") .. "/dev/nvim/relax",
      name = "relax.nvim",
      config = function()
        vim.cmd[[colorscheme relax]] -- it does change the colorscheme!
      end,
      enabled = enable_relax and use_relax,
    },
  }
end

local indent_level = 2

-- Keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set("n", "<leader>w", ":w<CR>") -- i type ':W' almost all the time
vim.keymap.set("n", "<leader>i", ":Inspect<CR>")
vim.keymap.set("n", "<leader>ts", function() vim.treesitter.start() end)
vim.keymap.set("n", "<leader>te", function() vim.treesitter.stop() end)

-- Line numbers
vim.o.number = true
-- vim.o.relativenumber = true

-- Indentation
vim.o.expandtab = true -- use spaces instead of '\t' character
vim.o.shiftwidth = indent_nevel -- how many spaces >> and << operators shift
vim.o.tabstop = indent_level -- how many spaces the <Tab> key inserts
vim.o.softtabstop = indent_level -- don't really know what this one is

-- Scrolling
vim.o.scrolloff = 8 -- minimum lines below and above the cursor

-- Colors
vim.o.termguicolors = true

-- C coding specifics
vim.env.CC = "clang" -- we don't have real GCC on Termux. It is basically clang
vim.g.c_syntax_for_h = 1

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system(
    {"git", "clone", "--filter=blob:none", "--branch=stable",
    lazyrepo, lazypath}
  )
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    -- { import = "plugins" },
    -- or put specs right here
    lazy_plugins()
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

