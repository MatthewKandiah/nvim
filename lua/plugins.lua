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

  -- file explorer -

end)
