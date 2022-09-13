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
  use 'PeterRincker/vim-argumentative'
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

  use {
    'cappyzawa/trim.nvim',
    config = function()
      require('trim').setup({
        disable = {"markdown"}
      })
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
  }

  use {
    'lewis6991/spellsitter.nvim',
    config = function()
      require('spellsitter').setup()
    end
  }

  use 'nvim-orgmode/orgmode'
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

  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
        highlight = {
          keyword = "bg",
          pattern = [[.*<(KEYWORDS)>]],
        },
        search = {
          pattern = [[\b(KEYWORDS)\b]]
        }
      }
    end
  }
  -- }}}

  -- UI {{{
  use 'kyazdani42/nvim-tree.lua'
  use 'preservim/tagbar'
  use 'kyazdani42/nvim-web-devicons'

  -- Color themes {{{
  use 'morhetz/gruvbox'
  -- use 'eddyekofo94/gruvbox-flat.nvim'
  -- }}}

  use {
    'nvim-lualine/lualine.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons',
      'arkav/lualine-lsp-progress',
    },
    config = function()
      require("lualine").setup{
        sections = {
          lualine_c = {'filename', 'lsp_progress'},
        }
      }
    end
  }
  use { 'goolord/alpha-nvim', requires = { 'kyazdani42/nvim-web-devicons' } }
  -- }}}

  -- VCS {{{
  use 'tpope/vim-fugitive'
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup {
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, {expr=true})

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, {expr=true})
        end
      }
    end
  }
  -- }}}

  -- LSP {{{
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason-lspconfig.nvim'
  use {
    'williamboman/mason.nvim',
    requires = 'williamboman/mason-lspconfig.nvim',
  }

  use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup({
          mode = "document_diagnostics",
          group = false,
          action_keys = {
            open_split = { "s" },
            open_vsplit = { "v" },
            open_tab = { "t" },
          },
          auto_preview = false,
        })
      end
  }
  -- }}}

  -- Autocomplete {{{
  use {
    'L3MON4D3/LuaSnip',
    tag = 'v1.*',
    config = function()
      require("luasnip.loaders.from_lua").load({
        paths = vim.fn.stdpath('config') .. "/lua/snippets"
      })
    end
  }
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
  -- }}}

  -- Language support {{{
  use 'ray-x/guihua.lua'
  use {
    'ray-x/go.nvim',
    -- TODO Add something to actually run GoInstallBinaries
    config = function()
      require('go').setup({
        goimport = "goimports"
      })
    end
  }

  use 'rust-lang/rust.vim'
  -- }}}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- vim: foldmethod=marker foldlevel=0
