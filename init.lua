require('plugins')

vim.keymap.set("n", "<Space>", "<Nop>", {silent = true})
vim.g.mapleader = " "

-- general vim settings
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

-- telescope bindings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
vim.keymap.set('n', '<leader>sf', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

-- nerdtree bindings
vim.keymap.set('n', '<F2>', ':NERDTreeToggle<CR>', {})

-- lsp-zero setup
--local lsp = require('lsp-zero').preset({
--  name = 'recommended',
--  sign_icons = {},
--})
--lsp.setup()

