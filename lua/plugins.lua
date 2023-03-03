vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- plugin manager - Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  use {'scrooloose/nerdtree'}

  -- colours
  use { 'folke/tokyonight.nvim' }
  vim.cmd('colorscheme tokyonight')

end)

