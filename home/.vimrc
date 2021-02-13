set nocompatible
filetype off

" Utility function for bootstrapping {{{
fun! LoadFiles(files)
    for file in a:files
        if filereadable(expand(file))
            execute "source " . file
        endif
    endfor
endfun
" }}}

" Bootstrap dotfiles {{{
    " Setup vim-plugin manager {{{
    fun! SetupVimPlug()
        " Define our install dir and add it to our runtime path
        let g:plugin_root_dir = expand('$HOME', 1) . '/.vim/plugins'
        let &rtp .= (empty(&rtp) ? '' : ',') . g:plugin_root_dir.'/vim-plug'

        " Clone vim-plug if we don't have it yet
        if !isdirectory(g:plugin_root_dir . '/vim-plug')
            echo "***********************************"
            echo "*   First time using this vimrc   *"
            echo "* Installing vim-plug and plugins *"
            echo "***********************************"
            silent execute '!git clone --depth=1 https://github.com/junegunn/vim-plug ' shellescape(g:plugin_root_dir . '/vim-plug', 1)
            let g:keelerm84_first_run = 1
        endif

        call LoadFiles([g:plugin_root_dir . '/vim-plug/plug.vim'])

        call plug#begin(g:plugin_root_dir)
        call LoadFiles(["~/.vim/config/bundles", "~/.vim.bundles.local"])
        call plug#end()
    endfun

    call SetupVimPlug()
    " }}}

    " Install plugins on first run {{{
    if exists('g:keelerm84_first_run')
        " If this is the first run we need to install all of the plugins
        PlugInstall
    endif
    " }}}

    call LoadFiles(["~/.vim/config/functions", "~/.vim/config/environment", "~/.vim.local"])
    call InitializeDirectories()
" }}}

" vim: ft=vim foldlevel=0 foldmethod=marker
