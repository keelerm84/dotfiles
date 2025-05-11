return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    keys = {
      { "<leader>nt", ":NvimTreeToggle<CR>", silent = true, desc = "NvimTree: Toggle file explorer" },
      { "<leader>nf", ":NvimTreeFindFile<CR>", silent = true, desc = "NvimTree: Find current file" },
    },
    opts = {
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        vim.keymap.set("n", "s", api.node.open.horizontal, opts("Open: Horizontal Split"))
        vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
        vim.keymap.set("n", "t", api.node.open.tab, opts("Open: New Tab"))
      end,
    },
  },
}
