return {
  {
    "sainnhe/gruvbox-material",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    init = function()
      vim.g.gruvbox_material_foreground = 'material'
      vim.g.gruvbox_material_background = 'soft'
      vim.g.gruvbox_material_disable_italic_comment = 1
    end,
    config = function()
      vim.cmd.colorscheme "gruvbox-material"
    end
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    opts = {
      scope = { enabled = true, }
    }
  },

  {
    'preservim/tagbar',
    keys = {
      { '<leader>tt', ':TagbarOpen fj<CR>', silent = true },
      { '<leader>tc', ':TagbarClose<CR>', silent = true },
    },
    init = function()
      vim.g.tagbar_type_haskell = {
        ctagsbin = 'hasktags',
        ctagsargs = '-x -c -o-',
        kinds = {
          'm:modules:0:1',
          'd:data: 0:1',
          'd_gadt: data gadt:0:1',
          't:type names:0:1',
          'nt:new types:0:1',
          'c:classes:0:1',
          'cons:constructors:1:1',
          'c_gadt:constructor gadt:1:1',
          'c_a:constructor accessors:1:1',
          'ft:function types:1:1',
          'fi:function implementations:0:1',
          'i:instance:0:1',
          'o:others:0:1',
        },
        sro = '.',
        kind2scope = {
          m = 'module',
          c = 'class',
          d = 'data',
          t = 'type',
          i = 'instance',
        },
        scope2kind = {
          module = 'm',
          class = 'c',
          data = 'd',
          type = 't',
          instance = 'i',
        }
      }

      vim.g.tagbar_type_ruby = {
        kinds = {
          'm:modules',
          'c:classes',
          'd:describes',
          'C:contexts',
          'i:things described with "it"',
          'f:methods',
          'F:singleton methods',
        }
      }
    end
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'kyazdani42/nvim-web-devicons',
    },
    opts = {
      sections = {
          lualine_c = {'filename'},
      }
    }
  },

  {
    "goolord/alpha-nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local dashboard = require("alpha.themes.dashboard")

      local banner = {
        "                                                    ",
        " ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        " ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        " ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        " ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        " ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        " ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        "                                                    ",
      }

      local function footer()
        local version = vim.version()
        local print_version = "v" .. version.major .. '.' .. version.minor .. '.' .. version.patch
        local datetime = os.date('%Y/%m/%d %H:%M:%S')

        return print_version .. ' ' .. datetime
      end

      dashboard.section.header.val = banner

      dashboard.section.buttons.val = {
        dashboard.button('e', '  New file', ':ene<CR>'),
        dashboard.button('f', '  Find file', ':NvimTreeOpen<CR>'),
        dashboard.button('s', '  Settings', ':e $MYVIMRC<CR>'),
        dashboard.button('q', '  Quit', ':qa<CR>'),
      }

      dashboard.section.footer.val = footer()

      -- available: devicons, mini, default is mini
      -- if provider not loaded and enabled is true, it will try to use another provider
      require("alpha").setup(
        dashboard.config
      )
    end,
  },
}
