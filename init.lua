require('plugins')

vim.keymap.set("n", "<Space>", "<Nop>", {silent = true})
vim.g.mapleader = " "

-- general vim settings
vim.opt.number = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- telescope bindings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
vim.keymap.set('n', '<leader>sf', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

-- nerdtree bindings
vim.keymap.set('n', '<leader>nt', ':NERDTreeToggle<CR>', {})

