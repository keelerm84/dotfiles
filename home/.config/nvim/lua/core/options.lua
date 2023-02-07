-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------

-- Default options are not included
-- See: https://neovim.io/doc/user/vim_diff.html
-- [2] Defaults - *nvim-defaults*

local g = vim.g       -- Global variables
local opt = vim.opt   -- Set options (global/buffer/windows-scoped)
local fn = vim.fn
local cmd = vim.cmd

cmd [[
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

set background=dark

" let g:gruvbox_contrast_dark='soft'
" colorscheme gruvbox

let g:gruvbox_material_foreground = 'original'
let g:gruvbox_material_background = 'soft'
let g:gruvbox_material_disable_italic_comment = 1
colorscheme gruvbox-material

" hi Normal ctermbg=none
]]

-- Add standard dictionary words if they exist
if fn.empty(fn.glob("/usr/share/dict/words")) == 0 then
  opt.dictionary:append("/usr/share/dict/words")
end

-- Always try to complete from the dictionary
opt.complete:append("k")
opt.completeopt = "menu,preview,longest"

-----------------------------------------------------------
-- General
-----------------------------------------------------------
-- opt.mouse = 'a'                       -- Enable mouse support
opt.spell = true
-- opt.swapfile = false                  -- Don't use swapfile
-- opt.completeopt = 'menuone,noinsert,noselect'  -- Autocomplete options
opt.undofile = true
opt.undolevels = 1000
opt.undoreload = 10000

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.cursorline = true
opt.virtualedit = 'onemore'
opt.wrap = false
opt.autoindent = true
opt.number = true           -- Show line number
opt.relativenumber = true
opt.showmatch = true        -- Highlight matching parenthesis
-- opt.foldmethod = 'marker'   -- Enable folding (default 'foldmarker')
-- opt.colorcolumn = '80'      -- Line lenght marker at 80 columns
opt.splitright = true       -- Vertical split to the right
opt.splitbelow = true       -- Horizontal split to the bottom
opt.ignorecase = true       -- Ignore case letters when search
opt.smartcase = true        -- Ignore lowercase for the whole pattern
-- opt.linebreak = true        -- Wrap on word boundary
opt.termguicolors = true    -- Enable 24-bit RGB colors
opt.laststatus=3            -- Set global statusline
opt.ttimeoutlen = 0
opt.timeoutlen = 500
opt.wildmode="list:longest,full"

-- cmd[[colorscheme gruvbox-flat]]

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true        -- Use spaces instead of tabs
opt.shiftwidth = 4          -- Shift 4 spaces when tab
opt.shiftround = true
opt.tabstop = 4             -- 1 tab == 4 spaces
opt.softtabstop = 4
opt.joinspaces = false
-- opt.smartindent = true      -- Autoindent new lines
opt.list = true
opt.listchars = "tab:› ,trail:•,extends:#,nbsp:." --  Highlight problematic whitespace

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true           -- Enable background buffers
opt.history = 1000           -- Remember N lines in history
opt.lazyredraw = true       -- Faster scrolling
opt.redrawtime = 3000
-- opt.synmaxcol = 240         -- Max column for syntax highlight
opt.updatetime = 300        -- ms to wait for trigger an event

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------
-- Disable nvim intro
-- opt.shortmess:append "sI"

-- Disable builtins plugins
local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end

g.rustfmt_autosave = 1
