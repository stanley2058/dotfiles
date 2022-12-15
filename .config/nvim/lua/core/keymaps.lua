vim.o.showcmd = true
vim.o.laststatus = 2
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true

vim.o.clipboard = 'unnamedplus'

vim.o.autoread = true
vim.o.backspace = '2'
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.shiftwidth = 2
vim.o.shiftround = true
vim.o.tabstop = 2

vim.keymap.set('n', '<C-Left>',  ':vertical resize +3<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Right>', ':vertical resize -3<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Up>', 	 ':resize +3<CR>',          { noremap = true, silent = true })
vim.keymap.set('n', '<C-Down>',  ':resize +3<CR>',          { noremap = true, silent = true })
