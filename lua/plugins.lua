vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- plugin manager - Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- fuzzy finder - telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- syntax highlighing - treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- file explorer - nerdtree
  use {'scrooloose/nerdtree'}

  -- lsp - lsp-zero
--  use {
--  'VonHeikemen/lsp-zero.nvim',
--  branch = 'v1.x',
--  requires = {
--    -- LSP Support
--    {'neovim/nvim-lspconfig'},             -- Required
--    {'williamboman/mason.nvim'},           -- Optional
--    {'williamboman/mason-lspconfig.nvim'}, -- Optional
--
--    -- Autocompletion
--    {'hrsh7th/nvim-cmp'},         -- Required
--    {'hrsh7th/cmp-nvim-lsp'},     -- Required
--    {'hrsh7th/cmp-buffer'},       -- Optional
--    {'hrsh7th/cmp-path'},         -- Optional
--    {'saadparwaiz1/cmp_luasnip'}, -- Optional
--    {'hrsh7th/cmp-nvim-lua'},     -- Optional
--
--    -- Snippets
--    {'L3MON4D3/LuaSnip'},             -- Required
--    {'rafamadriz/friendly-snippets'}, -- Optional
--  }
--}
  
  -- colours
  use { 'folke/tokyonight.nvim' }
  vim.cmd('colorscheme tokyonight')

end)

