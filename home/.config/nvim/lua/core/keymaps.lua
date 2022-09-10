-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Change leader to a comma
vim.g.mapleader = ' '

vim.cmd[[
let @d="/^\\(<<<<<<<\\|=======\\|>>>>>>>\\)\n"
]]

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------

-- Disable arrow keys
map('', '<up>', '<nop>')
map('', '<down>', '<nop>')
map('', '<left>', '<nop>')
map('', '<right>', '<nop>')

-- Open magit status buffer
map('n', '<leader>gs', ':Neogit<CR>')

-- Clear search highlighting with <leader> and c
map('n', '<leader>no', ':nohl<CR>')

-- Improved window manager and movement {{{
-- Move around splits using Ctrl + {h,j,k,l}
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Rebalance splits
map('n', '<leader>=', '<C-w>=')

map('n', 'j', 'gj')
map('n', 'k', 'gk')

map('n', 'Y', 'y$')

map('v', '<', '<gv')
map('v', '>', '>gv')
-- }}}

-- Saving and quitting {{{
map('n', 'zz', 'ZZ')
map('n', '<leader>w', ':wa<CR>')
map('c', 'w!!', 'w !sudo tee % >/dev/null')
-- }}}

-- Buffer management and navigation {{{
map('n', '<leader>ga', 'gg=G')
map('n', '<leader>v', ':vsp<CR>')
map('n', '<leader>h', ':sp<CR>')
-- }}}
--
-- Folding {{{
map('n', '<leader>ff', ':set foldmethod=syntax<CR>')
map('n', '<leader>fi', ':set foldmethod=indent<CR>')
map('n', '<leader>fm', ':set foldmethod=marker<CR>')
map('n', '<leader>fd', ':set foldmethod=diff<CR>')
map('n', '<leader>f0', ':set foldlevel=0<CR>')
map('n', '<leader>f1', ':set foldlevel=1<CR>')
map('n', '<leader>f2', ':set foldlevel=2<CR>')
map('n', '<leader>f3', ':set foldlevel=3<CR>')
map('n', '<leader>f4', ':set foldlevel=4<CR>')
map('n', '<leader>f5', ':set foldlevel=5<CR>')
map('n', '<leader>f6', ':set foldlevel=6<CR>')
map('n', '<leader>f7', ':set foldlevel=7<CR>')
map('n', '<leader>f8', ':set foldlevel=8<CR>')
map('n', '<leader>f9', ':set foldlevel=9<CR>')
-- }}}

-- Function Keys {{{
map('n', '<F2>', ':TodoQuickFix<CR>')
map('n', '<F3>', ':TroubleToggle<CR>')
-- }}}

-- Misc {{{
map('n', '<leader>fj', ':%!python -m json.tool<CR><Esc>:set filetype=json<CR>')
map('v', '<leader>fj', ":'<,'>!python -m json.tool<CR><Esc>:set filetype=json<CR>")
-- }}}

-- Reload configuration without restart nvim
map('n', '<leader>r', ':so %<CR>')

-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------

-- NvimTree {{{
map('n', '<leader>nt', ':NvimTreeToggle<CR>')            -- open/close
map('n', '<leader>nf', ':NvimTreeFindFile<CR>')      -- search file
-- }}}

-- Tagbar {{{
map('n', '<leader>tt', ':TagbarToggle<CR>')          -- open/close
-- }}}

-- Searching {{{
map('n', '<leader>gg', ':Ggrep<SPACE>', { silent = false })
-- }}}

-- FZF {{{
-- TODO(mmk): We need to port the SmartFzfSearching function here
map('n', '<C-p>', ':call SmartFzfSearching()<CR>')
map('n', 'g<C-p>', ':Files<CR>')
map('n', 'gs<C-p>', ':GFiles?<CR>')

map('n', '<leader>T', ':BTags<CR>')
map('n', 'g<leader>T', ':Tags<CR>')

map('n', '<leader>l', ':BLines<CR>')
map('n', 'g<leader>l', ':Lines<CR>')

map('n', '<leader>b', ':Buffers<CR>')

map('n', '<leader>c', ':BCommits<CR>')
map('n', 'g<leader>c', ':Commits<CR>')
-- }}}

-- vim: foldmethod=marker foldlevel=0
