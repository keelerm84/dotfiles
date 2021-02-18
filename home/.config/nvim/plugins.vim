" General utilities {{{
Plug 'junegunn/vim-plug'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'myusuf3/numbers.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'fweep/vim-tabber'
Plug 'Lokaltog/vim-easymotion'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/ZoomWin'
Plug 'bogado/file-line'
Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-abolish'
Plug 'skywind3000/asyncrun.vim'
Plug 'aquach/vim-http-client'
Plug 'junegunn/indentLine'
Plug 'enricobacis/paste.vim'
Plug 'SirVer/ultisnips'
" }}}

" Themes and appearance {{{
Plug 'spf13/vim-colors'
Plug 'altercation/vim-colors-solarized'
Plug 'sickill/vim-monokai'
Plug 'jnurmine/Zenburn'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" }}}

" Programming {{{
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'editorconfig/editorconfig-vim'
Plug 'jparise/vim-graphql'
Plug 'cespare/vim-toml'
Plug 'mattn/webapi-vim' " Required for gist-vim
Plug 'mattn/gist-vim'
Plug 'tpope/vim-commentary'
Plug 'godlygeek/tabular'
Plug 'PeterRincker/vim-argumentative'
Plug 'aklt/plantuml-syntax'
Plug 'fatih/vim-nginx'
Plug 'janko-m/vim-test'
Plug 'matze/vim-ini-fold'

if executable('ctags')
  Plug 'majutsushi/tagbar'
endif

" Git and VCS {{{
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'jreybert/vimagit'
Plug 'sgeb/vim-diff-fold'
" }}}

" C# {{{
Plug 'OmniSharp/omnisharp-vim'
" }}}

" Go {{{
Plug 'fatih/vim-go'
" }}}

" Haskell {{{
Plug 'neovimhaskell/haskell-vim'
" }}}

" HTML and CSS {{{
Plug 'alvan/vim-closetag'
Plug 'hail2u/vim-css3-syntax'
" }}}

" Java {{{
Plug 'mxw/vim-jsx'
Plug 'vim-scripts/vim-gradle'
" }}}

" Javascript {{{
Plug 'elzr/vim-json'
Plug 'groenewege/vim-less'
Plug 'yuezk/vim-js'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'digitaltoad/vim-jade'
" }}}

" PHP {{{
Plug 'vim-vdebug/vdebug'
Plug 'tobyS/pdv'
Plug 'tobyS/vmustache'
Plug 'alvan/vim-php-manual'
Plug 'stephpy/vim-php-cs-fixer'
Plug 'beyondwords/vim-twig'
Plug 'StanAngeloff/php.vim'
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}
" }}}

" Python {{{
Plug 'tmhedberg/SimpylFold'
Plug 'Konfekt/FastFold'
Plug 'vim-scripts/indentpython.vim'
Plug 'Glench/Vim-Jinja2-Syntax'
" }}}

" Ruby {{{
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'
" }}}

" Rust {{{
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
" }}}

" SQL {{{
Plug 'NLKNguyen/pipe-mysql.vim'
Plug 'NLKNguyen/pipe.vim'
" }}}

" }}}

" Search tools {{{
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'rking/ag.vim'
" }}}

" Markdown {{{
Plug 'tpope/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" }}}

" vim: ft=vim foldlevel=0 foldmethod=marker
