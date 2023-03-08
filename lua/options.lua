vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", '<leader>r', '<Cmd>LspZeroFormat<CR>')
vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.guicursor = ""
vim.scrolloff = 8
vim.opt.termguicolors = true
vim.opt.colorcolumn = "80"
vim.opt.signcolumn = 'yes'
vim.opt.autowriteall = true
