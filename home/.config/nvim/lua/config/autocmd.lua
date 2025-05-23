local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- Settings for filetypes:
-- Set indentation to 2 spaces
augroup("setIndent", { clear = true })
autocmd("Filetype", {
  group = "setIndent",
  pattern = {
    "css",
    "go",
    "html",
    "javascript",
    "lua",
    "ruby",
    "scss",
    "typescript",
    "typescriptreact",
    "xhtml",
    "xml",
    "yaml",
  },

  command = "setlocal shiftwidth=2 tabstop=2",
})

-- Terminal settings:
-- Open a Terminal on the right tab
autocmd("CmdlineEnter", {
  command = "command! Term :botright vsplit term://$SHELL",
})

-- Enter insert mode when switching to terminal
autocmd("TermOpen", {
  command = "setlocal listchars= nonumber norelativenumber nocursorline",
})

-- Close terminal buffer on process exit
autocmd("BufLeave", {
  pattern = "term://*",
  command = "stopinsert",
})

-- Open quickfix after populating list
autocmd("QuickFixCmdPost", {
  command = "copen 8",
})

autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "q", ":cclose<CR>", { noremap = true, silent = true })
  end,
})
