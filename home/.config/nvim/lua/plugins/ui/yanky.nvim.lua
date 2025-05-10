return {
  "gbprod/yanky.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>p",
      "<cmd>YankyRingHistory<CR>",
      mode = { "n", "v" },
      desc = "Ring History",
    },
  },
  opts = {
    highlight = {
      on_put = true,
      on_yank = true,
      timer = 150,
    },
    system_clipboard = {
      sync_with_ring = true,
    },
  },
}
