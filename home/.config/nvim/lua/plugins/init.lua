return {
  -- General utilities {{{
  { "PeterRincker/vim-argumentative" },
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },
  { "tpope/vim-unimpaired" },
  { "tpope/vim-speeddating" },

  -- Handles accidentally opened files without extension
  { "mong8se/actually.nvim" },

  -- breaks ability to switch panes in tmux with <C-arrows>
  -- { "mg979/vim-visual-multi" },
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

  -- ones I have in local
  -- Session handling
  {
    "dhruvasagar/vim-prosession",
    dependencies = {
      "tpope/vim-obsession",
    },
    init = function()
      vim.g.prosession_dir = vim.fn.stdpath("data") .. "/sessions/"
      os.execute("mkdir -pv " .. vim.g.prosession_dir)
    end,
  },

  -- Git-driven history
  {
    "ColinKennedy/vim-git-backup",
    init = function()
      vim.g.custom_backup_dir = vim.fn.stdpath("config") .. "/lua/local/backups/"
    end,
  },

  -- Fanciness
  { "dominikduda/vim_current_word" },
  { "wuelnerdotexe/vim-enfocado" },

  -- going to next searched item keeps you in the same spot
  { "haya14busa/vim-asterisk" },

  -- Better search
  {
    "kevinhwang91/nvim-hlslens",
    config = function()
      require("hlslens").setup()
    end,
  },

  { "Einenlum/yaml-revealer" },
  { "pedrohdz/vim-yaml-folds" },
}
