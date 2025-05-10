return {
  { 'tpope/vim-fugitive' },

  {
    "NeogitOrg/neogit",
    opts = {},
    keys = {
      { "<leader>gs", ":Neogit<CR>", silent = true },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",

      -- Look into replacing with telescope at some point in the future
      -- "nvim-telescope/telescope.nvim",
      "ibhagwan/fzf-lua",
    },
  },

  {
    'lewis6991/gitsigns.nvim',
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
    },
    opts = {
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
  }
}
