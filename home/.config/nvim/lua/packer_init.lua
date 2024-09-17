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
  use {
    'arthurxavierx/vim-caser',
    setup = function ()
      vim.g.caser_prefix = 'cr'
    end
  }
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  use 'mg979/vim-visual-multi'
  use 'fweep/vim-tabber'
  -- Consider replacing with https://github.com/phaazon/hop.nvim
  use 'Lokaltog/vim-easymotion'
  use 'milkypostman/vim-togglelist'

  use {
    'cappyzawa/trim.nvim',
    config = function()
      require('trim').setup({
        ft_blocklist = {"markdown"}
      })
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      local configuration = vim.fn['gruvbox_material#get_configuration']()
      local palette = vim.fn['gruvbox_material#get_palette'](configuration.background, configuration.foreground, configuration.colors_override)

      vim.api.nvim_set_hl(0, "@variable.php", { fg = palette.blue[1] })
    end,
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
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
    requires = {
      "nvim-lua/plenary.nvim",
      "sainnhe/gruvbox-material"
    },
    config = function()
      local configuration = vim.fn['gruvbox_material#get_configuration']()
      local palette = vim.fn['gruvbox_material#get_palette'](configuration.background, configuration.foreground, configuration.colors_override)

      require("todo-comments").setup {
        keywords = {
          FIX = {
            icon = " ", -- icon used for the sign, and in search results
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } -- a set of other keywords that all map to this FIX keywords
          },
          WARN = { icon = " ", alt = { "WARNING", "XXX" } },
          NOTE = { icon = "🗈 ", alt = { "INFO" } },
          QUESTION = { icon = "? ", color = "warning", alt = { "RESEARCH" } },
        },
        colors = {
          error = { palette.purple[1], "DiagnosticError", "ErrorMsg", "#DC2626" },
          warning = { palette.yellow[1], "DiagnosticWarn", "WarningMsg", "#FBBF24" },
          info = { palette.blue[1], "DiagnosticInfo", "#2563EB" },
          hint = { palette.blue[1], "DiagnosticHint", "#10B981" },
          default = {"Identifier", "#7C3AED" },
          test = { palette.aqua[1], "Identifier", "#FF00FF" }
        },
        merge_keywords = true,
        highlight = {
          keyword = "fg",
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
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require("ibl").setup {
        scope = {
       enabled = true,
       show_start = true,
       show_end = false,
       injected_languages = false,
       highlight = { "Function", "Label" },
       priority = 500,
          }
      }
    end
  }

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    }
  }
  use {
    'preservim/tagbar',
    config = function()
      vim.cmd[[
      let g:tagbar_type_haskell = {
        \ 'ctagsbin'  : 'hasktags',
        \ 'ctagsargs' : '-x -c -o-',
        \ 'kinds'     : [
            \  'm:modules:0:1',
            \  'd:data: 0:1',
            \  'd_gadt: data gadt:0:1',
            \  't:type names:0:1',
            \  'nt:new types:0:1',
            \  'c:classes:0:1',
            \  'cons:constructors:1:1',
            \  'c_gadt:constructor gadt:1:1',
            \  'c_a:constructor accessors:1:1',
            \  'ft:function types:1:1',
            \  'fi:function implementations:0:1',
            \  'i:instance:0:1',
            \  'o:others:0:1'
        \ ],
        \ 'sro'        : '.',
        \ 'kind2scope' : {
            \ 'm' : 'module',
            \ 'c' : 'class',
            \ 'd' : 'data',
            \ 't' : 'type',
            \ 'i' : 'instance'
        \ },
        \ 'scope2kind' : {
            \ 'module'   : 'm',
            \ 'class'    : 'c',
            \ 'data'     : 'd',
            \ 'type'     : 't',
            \ 'instance' : 'i'
        \ }
      \ }
      let g:tagbar_type_ruby = {
        \ 'kinds' : [
        \ 'm:modules',
        \ 'c:classes',
        \ 'd:describes',
        \ 'C:contexts',
        \ 'i:things described with "it"',
        \ 'f:methods',
        \ 'F:singleton methods'
        \ ]
        \ }
      ]]
    end
  }
  use 'kyazdani42/nvim-web-devicons'

  -- Color themes {{{
  use 'morhetz/gruvbox'
  use 'sainnhe/gruvbox-material'
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
  use {
    'TimUntersberger/neogit',
    requires = 'nvim-lua/plenary.nvim',
    config = require('neogit').setup({})
  }
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

  -- LSP / DAP {{{
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason-lspconfig.nvim'
  use 'williamboman/mason-nvim-dap.nvim'
  use 'williamboman/mason.nvim'
  use 'nvim-neotest/nvim-nio'
  use 'mfussenegger/nvim-dap'
  use {
    'rcarriga/nvim-dap-ui',
    requires = {'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio'},
    config = function()
      require('dapui').setup()

      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
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
  use 'github/copilot.vim'
  use 'ray-x/guihua.lua'
  use {
    'ray-x/go.nvim',
    -- TODO Add something to actually run GoInstallBinaries
    config = function()
      require('go').setup()
    end
  }

  use 'rust-lang/rust.vim'

  use 'lumiliet/vim-twig'

  use 'weihanglo/polar.vim'

  -- }}}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- vim: foldmethod=marker foldlevel=0
