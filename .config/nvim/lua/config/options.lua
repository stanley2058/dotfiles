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
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.shiftround = true
vim.o.expandtab = true

vim.o.updatetime = 50
vim.o.scrolloff = 8

vim.o.shell = "/usr/bin/bash"

vim.o.foldmethod = "marker"
vim.o.foldmarker = "#region,#endregion"

-- diagnostic with rounded borders
vim.diagnostic.config({
    float = { border = "rounded" },
})

if not vim.g.vscode then
    vim.o.termguicolors = true
    vim.o.cursorline = true
    vim.o.signcolumn = "yes"
    vim.o.colorcolumn = "80,120"
    vim.o.spell = true
end

vim.filetype.add({ extension = { templ = "templ" } })
vim.filetype.add({ extension = { ejs = "html" } })
