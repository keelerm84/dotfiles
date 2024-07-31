return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "kkharji/sqlite.lua",
    "folke/todo-comments.nvim",
  },
  config = function()
    local telescope = require("telescope")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
      },
    })

    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<C-p>", ":Telescope git_files<CR>", { desc = "Files: Known to git" })
    keymap.set("n", "<leader>b", ":Telescope buffers<CR>", { desc = "Buffers: Open buffers" })
    keymap.set("n", "<leader>bf", ":Telescope current_buffer_fuzzy_find<CR>", { desc = "Buffers: Find in current" })
    keymap.set("n", "<leader>bv", ":Telescope treesitter<CR>", { desc = "Buffer: Variables" })
    keymap.set("n", "<leader>c", ":Telescope git_commits<CR>", { desc = "Git: Commits" })
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
    keymap.set("n", "<leader>gg", ":Telescope live_grep<CR>", { desc = "Files: Search in files" })
    keymap.set("n", "g<C-p>", ":Telescope find_files<CR>", { desc = "Files: All files in directory" })
    keymap.set("n", "gs<C-p>", ":Telescope git_status<CR>", { desc = "Files: Modified (git status)" })
    keymap.set("n", "tr", ":Telescope resume<CR>", { desc = "Telescope: resume last" })
  end,
}
