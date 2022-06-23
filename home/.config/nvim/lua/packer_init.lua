-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- url: https://github.com/wbthomason/packer.nvim

-- For information about installed plugins see the README:
-- neovim-lua/README.md
-- https://github.com/brainfucksec/neovim-lua#readme


-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
end

-- Autocommand that reloads neovim whenever you save the packer_init.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer_init.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Install plugins
return packer.startup(function(use)
  -- Add you plugins here:
  use 'wbthomason/packer.nvim' -- packer can manage itself

  -- General utilities {{{
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-speeddating'
  use 'tpope/vim-abolish'
  use 'tpope/vim-commentary'
  use 'mg979/vim-visual-multi'
  use 'fweep/vim-tabber'
  -- Consider replacing with https://github.com/phaazon/hop.nvim
  use 'Lokaltog/vim-easymotion'
  -- }}}

  -- Search tools {{{
  use { 'junegunn/fzf', run = function() vf.fzf.install() end }
  use {
      'junegunn/fzf.vim',
      config = function()
          vim.g.fzf_action = {
              ['ctrl-t'] = 'tab split',
              ['ctrl-h'] = 'split',
              ['ctrl-v'] = 'vsplit',
          }

          vim.g.fzf_layout = {
              ['window'] = {
                  ['width'] = 0.9,
                  ['height'] = 0.9
              }
          }

          vim.g.fzf_preview_window = {'right:50%:hidden', 'ctrl-o'}

          vim.g.fzf_colors = {
            ['fg'] = {'fg', 'Normal'},
            ['bg'] = {'bg', 'Normal'},
            ['hl'] = {'fg', 'GruvboxAqua'},
            ['fg+'] = {'fg', 'String'},
            ['bg+'] = {'bg', 'Normal'},
            ['hl+'] = {'fg', 'GruvboxBlue'},
            ['info'] = {'fg', 'PreProc'},
            ['border'] = {'fg', 'Comment'},
            ['prompt'] = {'fg', 'GruvboxPurple'},
            ['pointer'] = {'fg', 'GruvboxPurple'},
            ['marker'] = {'fg', 'Keyword'},
            ['spinner'] = {'fg', 'Label'},
            ['header'] = {'fg', 'Comment'}
          }
      end
  }
  -- }}}

  -- File explorer
  use 'kyazdani42/nvim-tree.lua'

  -- Icons
  use 'kyazdani42/nvim-web-devicons'

  -- Tag viewer
  use 'preservim/tagbar'

  -- Treesitter interface
  use 'nvim-treesitter/nvim-treesitter'

  -- Orgmode
  use {
      'nvim-orgmode/orgmode', 
      config = function()
          require('orgmode').setup {}
      end
  }

  -- VCS
  use 'tpope/vim-fugitive'
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }

  -- Color schemes
  use 'morhetz/gruvbox'
  -- use 'eddyekofo94/gruvbox-flat.nvim'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
          require("trouble").setup {}
      end
  }

  -- Autocomplete
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'saadparwaiz1/cmp_luasnip',
    },
  }

  -- Statusline
  use {
    'feline-nvim/feline.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }

  -- git labels
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup()
    end
  }

  -- Dashboard (start screen)
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- vim: foldmethod=marker foldlevel=0
