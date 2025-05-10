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
}
