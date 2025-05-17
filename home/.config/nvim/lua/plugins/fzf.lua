return {
  {
    "junegunn/fzf",
    build = ":call fzf#install()",
  },

  {
    "junegunn/fzf.vim",
    dependencies = {
      "junegunn/fzf",
      "sainnhe/gruvbox-material",
    },
    keys = {
      { "<C-p>", ":call SmartFzfSearching()<CR>", silent = true },
      { "g<C-p>", ":Files<CR>", silent = true },
      { "gs<C-p>", ":GFiles?<CR>", silent = true },

      { "<leader>T", ":BTags<CR>", silent = true },
      { "g<leader>T", ":Tags<CR>", silent = true },

      { "<leader>l", ":BLines<CR>", silent = true },
      { "g<leader>l", ":Lines<CR>", silent = true },

      { "<leader>b", ":Buffers<CR>", silent = true },

      { "<leader>c", ":BCommits<CR>", silent = true },
      { "g<leader>c", ":Commits<CR>", silent = true },
    },
    init = function()
      vim.g.fzf_action = {
        ["ctrl-t"] = "tab split",
        ["ctrl-h"] = "split",
        ["ctrl-v"] = "vsplit",
      }

      vim.g.fzf_layout = {
        ["window"] = {
          ["width"] = 0.9,
          ["height"] = 0.9,
        },
      }

      vim.g.fzf_preview_window = { "right:50%:hidden", "ctrl-o" }
    end,
    config = function()
      local configuration = vim.fn["gruvbox_material#get_configuration"]()
      local palette = vim.fn["gruvbox_material#get_palette"](
        configuration.background,
        configuration.foreground,
        configuration.colors_override
      )

      vim.g.fzf_colors = {
        ["fg"] = { "fg", "Normal" },
        ["bg"] = { "bg", "Normal" },
        ["hl"] = { "fg", palette.aqua[1] },
        ["fg+"] = { "fg", "String" },
        ["bg+"] = { "bg", "Normal" },
        ["hl+"] = { "fg", palette.blue[1] },
        ["info"] = { "fg", "PreProc" },
        ["border"] = { "fg", "Comment" },
        ["prompt"] = { "fg", palette.purple[1] },
        ["pointer"] = { "fg", palette.purple[1] },
        ["marker"] = { "fg", "Keyword" },
        ["spinner"] = { "fg", "Label" },
        ["header"] = { "fg", "Comment" },
      }
    end,
  },
}
