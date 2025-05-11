return {
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sainnhe/gruvbox-material",
    },
    opts = {
      keywords = {
        FIX = { icon = "", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        WARN = { icon = "", alt = { "WARNING", "XXX" } },
        NOTE = { icon = "🗈", alt = { "INFO" } },
        QUESTION = { icon = "?", color = "warning", alt = { "RESEARCH" } },
      },
      colors = {
        error = { "GruvBoxPurple", "DiagnosticError", "ErrorMsg", "#DC2626" },
        warning = { "GruvBoxYellow", "DiagnosticWarn", "WarningMsg", "#FBBF24" },
        info = { "GruvBoxBlue", "DiagnosticInfo", "#2563EB" },
        hint = { "GruvBoxBlue", "DiagnosticHint", "#10B981" },
        default = { "Identifier", "#7C3AED" },
        test = { "GruvBoxAqua", "Identifier", "#FF00FF" },
      },
      merge_keywords = true,
      highlight = {
        keyword = "fg",
        pattern = [[.*<(KEYWORDS)>]],
      },
      search = {
        pattern = [[\b(KEYWORDS)\b]],
      },
    },
  },
}
