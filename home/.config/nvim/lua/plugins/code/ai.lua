return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false,
    opts = {
      provider = "claude",
      behavior = {
        enable_cursor_planning_mode = true,
      },
      windows = {
        width = 40,
        input = {
          height = 4,
        },
      },
    },
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "stevearc/dressing.nvim", -- for dressing provider
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "MeanderingProgrammer/render-markdown.nvim", -- for markdown rendering in preview window
      {
        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
        config = function()
          require("copilot").setup({
            panel = {
              auto_refresh = true,
            },
            suggestion = {
              auto_trigger = true,
              keymap = {
                accept = "<C-j>",
              },
            },
          })
        end,
      }, -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
    },
  },
}
