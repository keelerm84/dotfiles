return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      input = { enabled = true },
    },
  },

  {
    "sainnhe/gruvbox-material",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    init = function()
      vim.g.gruvbox_material_foreground = "material"
      vim.g.gruvbox_material_background = "soft"
      vim.g.gruvbox_material_disable_italic_comment = 1
      vim.g.termguicolors = true
    end,
    config = function()
      vim.cmd.colorscheme("gruvbox-material")
      vim.api.nvim_set_hl(0, "Todo", {})
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      scope = { enabled = false },
    },
  },

  {
    "szw/vim-maximizer",
    keys = {
      { "<C-w>z", ":MaximizerToggle<CR>", desc = "Maximize the current window" },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "kyazdani42/nvim-web-devicons",
      "sainnhe/gruvbox-material",
    },
    config = function()
      local lualine = require("lualine")
      local lazy_status = require("lazy.status") -- to configure lazy pending updates count

      local configuration = vim.fn["gruvbox_material#get_configuration"]()
      local palette = vim.fn["gruvbox_material#get_palette"](
        configuration.background,
        configuration.foreground,
        configuration.colors_override
      )

      lualine.setup({
        sections = {
          lualine_c = {
            "filename",
            "lsp_progress",
          },
          lualine_x = {
            {
              lazy_status.updates,
              cond = lazy_status.has_updates,
              color = { fg = palette.orange[1] },
            },
          },
        },
      })
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },

  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VimEnter",
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
        local print_version = "v" .. version.major .. "." .. version.minor .. "." .. version.patch
        local datetime = os.date("%Y/%m/%d %H:%M:%S")

        return print_version .. " " .. datetime
      end

      dashboard.section.header.val = banner

      dashboard.section.buttons.val = {
        dashboard.button("e", "  New file", ":ene<CR>"),
        dashboard.button("f", "  Find file", ":NvimTreeOpen<CR>"),
        dashboard.button("s", "  Settings", ":e $MYVIMRC<CR>"),
        dashboard.button("p", "  Plugins", ":Lazy<CR>"),
        dashboard.button("q", "  Quit", ":qa<CR>"),
      }

      dashboard.section.footer.val = footer()

      -- available: devicons, mini, default is mini
      -- if provider not loaded and enabled is true, it will try to use another provider
      require("alpha").setup(dashboard.config)
    end,
  },
}
