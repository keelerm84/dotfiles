" Colors {{{
set t_ut=  " Force vim to use the background color for the whole line

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

if (has("termguicolors"))
    set termguicolors
endif

set background=dark
let g:gruvbox_contrast_dark='soft'
colorscheme gruvbox

hi Normal ctermbg=none
" }}}

" General Settings {{{
filetype plugin indent on

" Enable modeline overrides (i.e. # vim: set sw=2)
set modeline

syntax on
set mousehide
scriptencoding utf-8
set encoding=utf-8

if has ('x') && has ('gui') " On Linux use + register for copy-paste
  set clipboard=unnamedplus
elseif has ('gui')          " On mac and Windows, use * register for copy-paste
  set clipboard=unnamed
endif

set cursorline
set viewoptions=folds,options,cursor,unix,slash
set virtualedit=onemore
set history=1000
set hidden
set spell

if filereadable("/usr/share/dict/words")
    set dictionary+="/usr/share/dict/words"
endif
set complete+=k

set splitbelow
set splitright

set backup
set backupcopy=yes
set undofile
set undolevels=1000
set undoreload=10000

set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

set showmode
set lazyredraw

set ruler
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
set showcmd

set ttimeoutlen=0
set timeoutlen=500
set completeopt=menu,preview,longest

set tags=./tags;/,~/.vimtags

set nowrap                      " Wrap long lines
set autoindent                  " Indent at the same level of the previous line
set shiftwidth=4                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set nojoinspaces                " When joining lines, don't use double spaces
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)

let mapleader = ' '
" }}}

" UI {{{
let g:tabber_divider_style = 'unicode'
set tabline=%!tabber#TabLine()

set laststatus=2

set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set nu                          " Line numbers on
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set foldenable                  " Auto fold code
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
let g:airline_powerline_fonts = 1
let g:airline_theme='tomorrow'
let g:airline_section_c = '%t'
let g:airline_skip_empty_sections = 1
" Sections are defined as
" a      displays mode + additional flags like crypt/spell/paste (`INSERT`)
" b      VCS information (branch, hunk summary) (`master`)
" c      filename + read-only flag (`~/.vim/vimrc RO`)
" x      filetype  (`vim`)
" y      file encoding[fileformat] (`utf-8[unix]`)
" z      current position in the file
let g:airline#extensions#default#section_truncate_width = {
    \ 'a': 60,
    \ 'b': 150,
    \ 'x': 79,
    \ 'y': 120,
    \ 'z': 60,
    \ 'warning': 79,
    \ 'error': 79,
\ }
" }}}

" Improved window management and movement {{{
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-L> <C-W>l
noremap <C-H> <C-W>h
noremap <Leader>= <C-w>=

nnoremap j gj
nnoremap k gk

nnoremap Y y$

vnoremap < <gv
vnoremap > >gv
" }}}

" Searching {{{
nnoremap <leader>gg :Ggrep<SPACE>
nnoremap <leader>ag :Ag<SPACE>
" }}}
"
" Folding {{{
nnoremap <leader>ff :set foldmethod=syntax<CR>
nnoremap <leader>fi :set foldmethod=indent<CR>
nnoremap <leader>fm :set foldmethod=marker<CR>
nnoremap <leader>fd :set foldmethod=diff<CR>
nnoremap <leader>f0 :set foldlevel=0<CR>
nnoremap <leader>f1 :set foldlevel=1<CR>
nnoremap <leader>f2 :set foldlevel=2<CR>
nnoremap <leader>f3 :set foldlevel=3<CR>
nnoremap <leader>f4 :set foldlevel=4<CR>
nnoremap <leader>f5 :set foldlevel=5<CR>
nnoremap <leader>f6 :set foldlevel=6<CR>
nnoremap <leader>f7 :set foldlevel=7<CR>
nnoremap <leader>f8 :set foldlevel=8<CR>
nnoremap <leader>f9 :set foldlevel=9<CR>
" }}}

" Saving and quitting {{{
nnoremap zz ZZ
nnoremap <silent> <leader>w :wa<CR>
cnoremap w!! w !sudo tee % >/dev/null
" }}}

" Buffer management and navigation {{{
nnoremap <leader>ga gg=G
nnoremap <leader>db :bp\|bd#<CR>
nnoremap <leader>adb :bufdo bdelete<CR>
command! Bdi :call functions#DeleteInactiveBufs()

nnoremap <leader>gn :bn<CR>
nnoremap <leader>gp :bp<CR>
nnoremap <leader>tn :tabnew<CR>

let g:paste_no_mappings = 1
nnoremap <leader>v :vsp<CR>
nnoremap <leader>h :sp<CR>
" }}}

" Misc {{{
nnoremap <leader>fj :%!python -m json.tool<CR><Esc>:set filetype=json<CR>
vnoremap <leader>fj :'<,'>!python -m json.tool<CR><Esc>:set filetype=json<CR>

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
nnoremap <leader>p :Paste<CR>

nmap <leader>fs :syn sync fromstart<CR>
nnoremap <leader>no :noh<CR>
noremap <F11> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

autocmd Syntax * syntax keyword Todo contained WARN NOTE FIXME XXX TODO ATTN containedin=.*Comment
autocmd FileType * autocmd CursorMovedI,InsertLeave * call functions#ClosePreviewWindow()
autocmd FileType * autocmd BufWritePre <buffer> call functions#StripTrailingWhitespace()
autocmd QuickFixCmdPost * call asyncrun#quickfix_toggle(8, 1)

let @d='/^\(<<<<<<<\||||||||\|=======\|>>>>>>>\)' " Navigating merge conflict
" }}}

" vim: ft=vim foldlevel=0 foldmethod=marker
