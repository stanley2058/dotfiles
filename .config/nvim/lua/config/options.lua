-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = " "

vim.o.showcmd = true
vim.o.laststatus = 2
vim.o.number = true
vim.o.relativenumber = true

vim.o.hlsearch = true
vim.o.incsearch = true

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
vim.o.scrolloff = 8

vim.o.shell = "/usr/bin/bash"

-- diagnostic with rounded borders
vim.diagnostic.config({
    float = { border = "rounded" },
})

if not vim.g.vscode then
    vim.o.termguicolors = true
    vim.o.cursorline = true
    vim.o.signcolumn = "yes"
    vim.o.colorcolumn = "80"
end
