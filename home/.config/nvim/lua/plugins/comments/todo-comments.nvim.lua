return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sainnhe/gruvbox-material",
  },
  config = function()
    local todo_comments = require("todo-comments")
    local configuration = vim.fn["gruvbox_material#get_configuration"]()

    local palette = vim.fn["gruvbox_material#get_palette"](
      configuration.background,
      configuration.foreground,
      configuration.colors_override
    )

    todo_comments.setup({
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
        },
        WARN = { icon = " ", alt = { "WARNING", "XXX" } },
        NOTE = { icon = " ", alt = { "INFO" } },
        QUESTION = { icon = "? ", color = "warning", alt = { "RESEARCH" } },
      },
      colors = {
        error = { palette.purple[1], "DiagnosticError", "ErrorMsg", "#DC2626" },
        warning = { palette.yellow[1], "DiagnosticWarn", "WarningMsg", "#FBBF24" },
        info = { palette.blue[1], "DiagnosticInfo", "#2563EB" },
        hint = { palette.blue[1], "DiagnosticHint", "#10B981" },
        default = { "Identifier", "#7C3AED" },
        test = { palette.aqua[1], "Identifier", "#FF00FF" },
      },
      merge_keywords = true,
      highlight = {
        keyword = "bg",
        pattern = [[.*<(KEYWORDS)>]],
      },
      search = {
        pattern = [[\b(KEYWORDS)\b]],
      },
    })

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    -- These appear to conflict with tag stacks?
    -- keymap.set("n", "]t", function()
    --   todo_comments.jump_next()
    -- end, { desc = "Next todo comment" })
    --
    -- keymap.set("n", "[t", function()
    --   todo_comments.jump_prev()
    -- end, { desc = "Previous todo comment" })

    todo_comments.setup()

    keymap.set("n", "<F2>", "call ToggleQuickfixList()<CR>", { desc = "Quick fix list: Toggle" })
    keymap.set("n", "<F3>", ":TodoQuickFix<CR>", { desc = "Quick fix list: Cycle" })
  end,
}
