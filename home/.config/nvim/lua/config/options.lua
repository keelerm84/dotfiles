local opt = vim.opt
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Add standard dictionary words if they exist
if vim.fn.empty(vim.fn.glob("/usr/share/dict/words")) == 0 then
  opt.dictionary:append("/usr/share/dict/words")
end

opt.complete:append("k")
opt.spell = true

opt.undofile = true

--
-- Basic UI
--
opt.cursorline = true
opt.virtualedit = 'onemore'
opt.wrap = false
opt.number = true
opt.relativenumber = true
opt.showmatch = true
opt.splitright = true
opt.splitbelow = true
opt.ignorecase = true
opt.smartcase = true
opt.linebreak = true
opt.termguicolors = true
opt.laststatus=3
opt.ttimeoutlen = 0
opt.timeoutlen = 500
opt.wildmode="list:longest,full"

--
-- Tabs, indent
--
opt.expandtab = true
opt.shiftwidth = 4
opt.shiftround = true
opt.tabstop = 4
opt.softtabstop = 4
opt.joinspaces = false
opt.list = true
opt.listchars = "tab:› ,trail:•,extends:#,nbsp:." --  Highlight problematic whitespace

--
-- Memory, CPU
--
opt.history = 1000
opt.lazyredraw = true
opt.redrawtime = 3000
