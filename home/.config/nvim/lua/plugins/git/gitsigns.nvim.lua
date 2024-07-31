return {
  "lewis6991/gitsigns.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "kyazdani42/nvim-web-devicons",
  },
  config = function()
    require("gitsigns").setup({
      numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
      linehl = true, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = true, -- Toggle with `:Gitsigns toggle_word_diff`

      -- watch_gitdir = {
      --   follow_files = true,
      -- },
      -- auto_attach = true,
      -- attach_to_untracked = false,

      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 100,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },

      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end)

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end)

        -- Actions
        map("n", "<leader>gbt", gitsigns.toggle_current_line_blame, { desc = "Toggle current line blame" })
        map("n", "<leader>gb", gitsigns.blame)
        map("n", "<leader>gbl", function()
          gitsigns.blame_line({ full = true })
        end)

        map("n", "<leader>gd", gitsigns.diffthis)
        map("n", "<leader>gD", function()
          gitsigns.diffthis("~")
        end)
      end,
    })
  end,
}
