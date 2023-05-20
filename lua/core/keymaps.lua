vim.keymap.set('n', '<SPACE>', 'Nop')
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.number = true
vim.opt.relativenumber = true

-- de-highlight 
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
-- exit
vim.keymap.set('n', '<leader>e', ':wqa<CR>')
-- error jumping
vim.keymap.set('n', '<F2>', vim.diagnostic.goto_next, {})
vim.keymap.set('n', '<F3>', vim.diagnostic.goto_prev, {})
-- system copy-paste
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>p', '"+p')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>p', '"+p')
-- window splitting
vim.keymap.set('n', '<leader><Left>', "<C-W><Left>")
vim.keymap.set('n', '<leader><Right>', "<C-W><Right>")
vim.keymap.set('n', '<leader><Up>', "<C-W><Up>")
vim.keymap.set('n', '<leader><Down>', "<C-W><Down>")
vim.keymap.set('n', '<leader>v', "<C-W>v")
vim.keymap.set('n', '<leader>n', "<C-W><C-N>")
vim.keymap.set('n', '<leader>q', "<C-W>q")
