-----------------------------------------------------------
-- Autocommand functions
-----------------------------------------------------------

-- Define autocommands with Lua APIs
-- See: h:api-autocmd, h:augroup

local augroup = vim.api.nvim_create_augroup   -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand

-- Settings for filetypes:
-- Set indentation to 2 spaces
augroup('setIndent', { clear = true })
autocmd('Filetype', {
  group = 'setIndent',
  pattern = { 'css', 'html', 'javascript', 'lua', 'ruby' , 'scss', 'typescript', 'typescriptreact', 'xhtml', 'xml', 'yaml' },
  command = 'setlocal shiftwidth=2 tabstop=2'
})

-- Terminal settings:
-- Open a Terminal on the right tab
autocmd('CmdlineEnter', {
  command = 'command! Term :botright vsplit term://$SHELL'
})

-- Enter insert mode when switching to terminal
autocmd('TermOpen', {
  command = 'setlocal listchars= nonumber norelativenumber nocursorline',
})

autocmd('TermOpen, TermEnter', {
  pattern = 'term://*',
  command = 'startinsert'
})

-- Add blank line and move into insert mode when committing via Neogit
autocmd('BufEnter', {
  pattern = 'COMMIT_EDITMSG',
  callback = function()
    local ok, wasEntered = pcall(vim.api.nvim_buf_get_var, 0, 'mmk:wasEntered')

    if ok and wasEntered then
      return
    end

    vim.api.nvim_buf_set_var(0, 'mmk:wasEntered', 1)
    vim.api.nvim_command('normal O')
    vim.cmd('startinsert')
  end
})

-- Close terminal buffer on process exit
autocmd('BufLeave', {
  pattern = 'term://*',
  command = 'stopinsert'
})

autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    require('go.format').goimport()
  end
})

-- Open quickfix after populating list
autocmd('QuickFixCmdPost', {
  command = 'copen 8'
})

autocmd('FileType', {
  pattern = "qf",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "q", ":cclose<CR>", { noremap = true, silent = true })
  end
})
