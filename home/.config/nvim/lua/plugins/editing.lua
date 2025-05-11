return {
  { 'PeterRincker/vim-argumentative' },
  { 'tpope/vim-surround' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-unimpaired' },
  { 'tpope/vim-speeddating' },

  { "mong8se/actually.nvim" },

  {
    'arthurxavierx/vim-caser',
    init = function()
      vim.g.caser_prefix = 'cr'
    end,
  },

  {
    'numToStr/Comment.nvim',
    event = { "BufReadPre", "BufNewFile" },
  },
  { 'mg979/vim-visual-multi' },
  { 'fweep/vim-tabber' },

  -- Consider replacing with https://github.com/phaazon/hop.nvim
  { 'Lokaltog/vim-easymotion' },
  { 'milkypostman/vim-togglelist' },

  {
    'cappyzawa/trim.nvim',
    opts = {
      ft_blocklist = {"markdown"}
    },
  },

  {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    config = function()
      -- import nvim-autopairs
      local autopairs = require("nvim-autopairs")

      -- configure autopairs
      autopairs.setup({
        check_ts = true, -- enable treesitter
        ts_config = {
          lua = { "string" }, -- don't add pairs in lua string treesitter nodes
          javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
          java = false, -- don't check treesitter on java
        },
      })

      -- make autopairs and completion work together
      require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
    end,
  },
}
