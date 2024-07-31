local function on_attach(bufnr)
  local FloatPreview = require("float-preview")
  FloatPreview.attach_nvimtree(bufnr)

  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- Default mappings. Feel free to modify or remove as you wish.
  --
  -- BEGIN_DEFAULT_ON_ATTACH
  vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
  vim.keymap.set("n", "<C-e>", api.node.open.replace_tree_buffer, opts("Open: In Place"))
  vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts("Info"))
  vim.keymap.set("n", "<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
  vim.keymap.set("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
  vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
  vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
  vim.keymap.set("n", "<BS>", api.node.navigate.parent_close, opts("Close Directory"))
  vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
  vim.keymap.set("n", ">", api.node.navigate.sibling.next, opts("Next Sibling"))
  vim.keymap.set("n", "<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
  vim.keymap.set("n", ".", api.node.run.cmd, opts("Run Command"))
  vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts("Up"))
  vim.keymap.set("n", "a", api.fs.create, opts("Create"))
  vim.keymap.set("n", "bmv", api.marks.bulk.move, opts("Move Bookmarked"))
  vim.keymap.set("n", "B", api.tree.toggle_no_buffer_filter, opts("Toggle No Buffer"))
  vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
  vim.keymap.set("n", "C", api.tree.toggle_git_clean_filter, opts("Toggle Git Clean"))
  vim.keymap.set("n", "[c", api.node.navigate.git.prev, opts("Prev Git"))
  vim.keymap.set("n", "]c", api.node.navigate.git.next, opts("Next Git"))
  vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
  vim.keymap.set("n", "D", api.fs.trash, opts("Trash"))
  vim.keymap.set("n", "E", api.tree.expand_all, opts("Expand All"))
  vim.keymap.set("n", "e", api.fs.rename_basename, opts("Rename: Basename"))
  vim.keymap.set("n", "]e", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
  vim.keymap.set("n", "[e", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
  vim.keymap.set("n", "F", api.live_filter.clear, opts("Clean Filter"))
  vim.keymap.set("n", "f", api.live_filter.start, opts("Filter"))
  vim.keymap.set("n", "g?", api.tree.toggle_help, opts("Help"))
  vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
  vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
  vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
  vim.keymap.set("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
  vim.keymap.set("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
  vim.keymap.set("n", "m", api.marks.toggle, opts("Toggle Bookmark"))
  vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "O", api.node.open.no_window_picker, opts("Open: No Window Picker"))
  vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
  vim.keymap.set("n", "P", api.node.navigate.parent, opts("Parent Directory"))
  vim.keymap.set("n", "q", api.tree.close, opts("Close"))
  vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
  vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
  vim.keymap.set("n", "s", api.node.run.system, opts("Run System"))
  vim.keymap.set("n", "S", api.tree.search_node, opts("Search"))
  vim.keymap.set("n", "U", api.tree.toggle_custom_filter, opts("Toggle Hidden"))
  vim.keymap.set("n", "W", api.tree.collapse_all, opts("Collapse"))
  vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
  vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
  vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
  vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node, opts("CD"))
  -- END_DEFAULT_ON_ATTACH

  -- Mappings migrated from view.mappings.list
  --
  -- You will need to insert "your code goes here" for any mappings with a custom action_cb
  vim.keymap.set("n", "s", api.node.open.horizontal, opts("Open: Horizontal Split"))
  vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
  vim.keymap.set("n", "t", api.node.open.tab, opts("Open: New Tab"))
end

return {
  "kyazdani42/nvim-tree.lua",
  dependencies = {
    "kyazdani42/nvim-web-devicons",
    {
      "JMarkin/nvim-tree.lua-float-preview",
      lazy = true,
      -- default
      opts = {
        -- Whether the float preview is enabled by default. When set to false, it has to be "toggled" on.
        toggled_on = true,
        -- wrap nvimtree commands
        wrap_nvimtree_commands = true,
        -- lines for scroll
        scroll_lines = 20,
        -- window config
        window = {
          style = "minimal",
          relative = "win",
          border = "rounded",
          wrap = false,
        },
        mapping = {
          -- scroll down float buffer
          down = { "<C-d>" },
          -- scroll up float buffer
          up = { "<C-e>", "<C-u>" },
          -- enable/disable float windows
          toggle = { "<C-x>" },
        },
        -- hooks if return false preview doesn't shown
        hooks = {
          pre_open = function(path)
            -- if file > 5 MB or not text -> not preview
            local size = require("float-preview.utils").get_size(path)
            if type(size) ~= "number" then
              return false
            end
            local is_text = require("float-preview.utils").is_text(path)
            return size < 5 and is_text
          end,
          post_open = function(bufnr)
            return true
          end,
        },
      },
    },
  },
  lazy = false, -- https://github.com/nvim-tree/nvim-tree.lua/wiki/Installation#lazy-loading
  config = function()
    --   require("nvim-tree").setup({
    --     auto_reload_on_write = true,
    --     create_in_closed_folder = false,
    --     hijack_netrw = true,
    --     open_on_tab = true,
    --     sort_by = "name",
    --     reload_on_bufenter = false,
    --     respect_buf_cwd = false,
    --     update_cwd = true,
    --     renderer = {
    --       add_trailing = false,
    --       group_empty = false,
    --       highlight_git = false,
    --       highlight_opened_files = "none",
    --       root_folder_modifier = ":~",
    --       indent_markers = {
    --         enable = false,
    --         icons = {
    --           corner = "└ ",
    --           edge = "│ ",
    --           none = "  ",
    --         },
    --       },
    --       icons = {
    --         webdev_colors = true,
    --         git_placement = "before",
    --         padding = " ",
    --         symlink_arrow = " ➛ ",
    --         show = {
    --           file = true,
    --           folder = true,
    --           folder_arrow = true,
    --           git = true,
    --         },
    --         glyphs = {
    --           default = "",
    --           symlink = "",
    --           folder = {
    --             arrow_closed = "",
    --             arrow_open = "",
    --             default = "",
    --             open = "",
    --             empty = "",
    --             empty_open = "",
    --             symlink = "",
    --             symlink_open = "",
    --           },
    --           git = {
    --             unstaged = "✗",
    --             staged = "✓",
    --             unmerged = "",
    --             renamed = "➜",
    --             untracked = "★",
    --             deleted = "",
    --             ignored = "◌",
    --           },
    --         },
    --       },
    --       special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
    --     },
    --     hijack_directories = {
    --       enable = true,
    --       auto_open = false,
    --     },
    --     update_focused_file = {
    --       enable = true,
    --       update_root = true,
    --     },
    --     system_open = {
    --       cmd = "",
    --       args = {},
    --     },
    --     diagnostics = {
    --       enable = true,
    --       show_on_dirs = false,
    --       icons = {
    --         hint = "",
    --         info = "",
    --         warning = "",
    --         error = "",
    --       },
    --     },
    --     filters = {
    --       dotfiles = false,
    --       custom = {},
    --       exclude = {},
    --     },
    --     git = {
    --       enable = true,
    --       ignore = true,
    --       timeout = 400,
    --     },
    --     actions = {
    --       use_system_clipboard = true,
    --       change_dir = {
    --         enable = false,
    --         global = false,
    --         restrict_above_cwd = false,
    --       },
    --       open_file = {
    --         quit_on_open = false,
    --         resize_window = true,
    --         window_picker = {
    --           enable = true,
    --           chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
    --           exclude = {
    --             filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
    --             buftype = { "nofile", "terminal", "help" },
    --           },
    --         },
    --       },
    --     },
    --     trash = {
    --       cmd = "trash",
    --       require_confirm = true,
    --     },
    --     live_filter = {
    --       prefix = "[FILTER]: ",
    --       always_show_folders = true,
    --     },
    --     log = {
    --       enable = false,
    --       truncate = false,
    --       types = {
    --         all = false,
    --         config = false,
    --         copy_paste = false,
    --         diagnostics = false,
    --         git = false,
    --         profile = false,
    --       },
    --     },
    --   })

    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      on_attach = on_attach,
      view = {
        width = 32,
        -- side = "left",
        -- preserve_window_proportions = false,
        number = false,
        -- relativenumber = false,
        -- signcolumn = "yes",
      },
      -- change folder arrow icons
      renderer = {
        indent_markers = {
          enable = true,
        },
      },
      filters = {
        custom = { ".DS_Store" },
      },
      git = {
        ignore = false,
      },
    })

    -- Auto close if last window.
    vim.api.nvim_create_autocmd("BufEnter", {
      nested = true,
      callback = function()
        if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
          vim.cmd("quit")
        end
      end,
    })

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>nt", "<cmd>NvimTreeToggle<CR>", { desc = "NvimTree: Toggle file explorer" })
    keymap.set("n", "<leader>nf", "<cmd>NvimTreeFindFile<CR>", { desc = "NvimTree: Find current file" })
  end,
}
