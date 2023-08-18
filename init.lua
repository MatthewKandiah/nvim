-- learn to use lua in neovim by searching `:help lua-guide`
-- Set <space> as the leader key
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('dependencies')
require('options')
require('debugging')
require('ts-context')
require('keymaps')
require('commands')
require('telescope-setup')
require('treesitter-setup')
require('lsp-setup')
require('cmp-setup')

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
