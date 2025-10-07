local function map(mode, lhs, rhs, opts)
  local options = { silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

vim.fn.setreg("d", [[/^\(<<<<<<<\|=======\|>>>>>>>\)]])

--
-- Neovim shortcuts
--

-- Clear search highlighting with <leader> and c
map("n", "<leader>no", ":nohl<CR>")
map("n", "<leader>rl", ":bufdo e!<CR>e")

-- Quickfix navigation
map("n", "<M-j>", ":cnext<CR>")
map("n", "<M-k>", ":cprev<CR>")
map("n", "<M-l>", ":cnewer<CR>")
map("n", "<M-h>", ":colder<CR>")

-- Improved window manager and movement {{{
-- Move around splits using Ctrl + {h,j,k,l}
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Also mapping these to Ctrl + arrows for Beshoy
map("n", "<C-Left>", "<C-w>h")
map("n", "<C-Down>", "<C-w>j")
map("n", "<C-Up>", "<C-w>k")
map("n", "<C-Right>", "<C-w>l")

-- Rebalance splits
map("n", "<leader>=", "<C-w>=")

map("n", "j", "gj")
map("n", "k", "gk")

map("n", "Y", "y$")

map("v", "<", "<gv")
map("v", ">", ">gv")
-- }}}

-- Saving and quitting {{{
map("v", "<leader>y", '"+y')
map("n", "zz", "ZZ")
map("n", "<leader>w", ":wa<CR>")
map("c", "w!!", "w !sudo tee % >/dev/null")
-- }}}

-- Buffer management and navigation {{{
map("n", "<leader>ga", "gg=G")
map("n", "<leader>v", ":vsp<CR>")
map("n", "<leader>h", ":sp<CR>")
-- }}}
--
-- Folding {{{
map("n", "<leader>ff", ":set foldmethod=syntax<CR>")
map("n", "<leader>fi", ":set foldmethod=indent<CR>")
map("n", "<leader>fm", ":set foldmethod=marker<CR>")
map("n", "<leader>fd", ":set foldmethod=diff<CR>")
map("n", "<leader>f0", ":set foldlevel=0<CR>")
map("n", "<leader>f1", ":set foldlevel=1<CR>")
map("n", "<leader>f2", ":set foldlevel=2<CR>")
map("n", "<leader>f3", ":set foldlevel=3<CR>")
map("n", "<leader>f4", ":set foldlevel=4<CR>")
map("n", "<leader>f5", ":set foldlevel=5<CR>")
map("n", "<leader>f6", ":set foldlevel=6<CR>")
map("n", "<leader>f7", ":set foldlevel=7<CR>")
map("n", "<leader>f8", ":set foldlevel=8<CR>")
map("n", "<leader>f9", ":set foldlevel=9<CR>")
-- }}}

-- Misc {{{
map("n", "<leader>fj", ":%!python -m json.tool<CR><Esc>:set filetype=json<CR>")
map("v", "<leader>fj", ":'<,'>!python -m json.tool<CR><Esc>:set filetype=json<CR>")

map("n", "<leader>gg", ":Ggrep<SPACE>", { silent = false })
map("n", "<leader>adb", ":%bd<CR>")
-- }}}

-- vim: foldmethod=marker foldlevel=0
