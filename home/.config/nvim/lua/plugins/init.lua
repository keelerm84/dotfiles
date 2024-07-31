return {
  -- General utilities {{{
  { "PeterRincker/vim-argumentative" },
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },
  { "tpope/vim-unimpaired" },
  { "tpope/vim-speeddating" },

  -- Handles accidentally opened files without extension
  { "mong8se/actually.nvim" },

  { "mg979/vim-visual-multi" },
  { "fweep/vim-tabber" },

  -- Consider replacing with https://github.com/phaazon/hop.nvim
  { "Lokaltog/vim-easymotion" },
  { "milkypostman/vim-togglelist" },

  {
    "nvim-orgmode/orgmode",
    config = function()
      require("orgmode").setup({
        org_agenda_files = { "~/Documents/Dropbox/OrgFiles/**/*" },
        org_default_notes_file = "~/Documents/Dropbox/OrgFiles/refile.org",
      })
    end,
  },

  {
    "arthurxavierx/vim-caser",
    init = function()
      vim.g.caser_prefix = "cr"
    end,
  },
}
