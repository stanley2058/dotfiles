vim.g.mapleader = " "
vim.o.termguicolors = true

vim.o.showcmd = true
vim.o.laststatus = 2
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true

vim.o.hlsearch = true
vim.o.incsearch = true

vim.o.clipboard = "unnamedplus"

vim.o.autoread = true
vim.o.backspace = "2"

vim.o.smarttab = true
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.shiftround = true
vim.o.expandtab = true

vim.o.updatetime = 50
vim.o.colorcolumn = "80"

vim.o.scrolloff = 8
vim.o.signcolumn = "yes"

vim.cmd([[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]])
