" InitializeDirectories {{{
function! functions#InitializeDirectories()
  let dir_list = {
    \ 'backupdir': 'backup//',
    \ 'viewdir': 'views//',
    \ 'directory': 'swap//',
    \ 'undodir': 'undo//' }

  for [settingname, dirname] in items(dir_list)
      let directory = stdpath('config') . '/cache/' . dirname
      if exists("*mkdir")
          call mkdir(directory, "p")
      endif

      if !isdirectory(directory)
          echo "Warning: Unable to create backup directory: " . directory
          echo "Try: mkdir -p " . directory
      else
          let directory = substitute(directory, " ", "\\\\ ", "g")
          exec "set " . settingname . "=" . directory
      endif
  endfor
endfunction
" }}}

" ClosePreviewWindow {{{
function! functions#ClosePreviewWindow()
    if exists('b:noClosePreview')
        return
    endif

    if pumvisible() == 0
        silent! pclose
    endif
endfunction
" }}}

" StripTrailingWhitespace {{{
function! functions#StripTrailingWhitespace()
  if exists('b:noStripWhitespace')
    return
  endif

  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " do the business:
  %s/\s\+$//e
  " clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
" }}}

" DeleteInactiveBufs {{{
function! functions#DeleteInactiveBufs()
    "From tabpagebuflist() help, get a list of all buffers in all tabs
    let tablist = []
    for i in range(tabpagenr('$'))
        call extend(tablist, tabpagebuflist(i + 1))
    endfor

    "Below originally inspired by Hara Krishna Dara and Keith Roberts
    "http://tech.groups.yahoo.com/group/vim/message/56425
    let nWipeouts = 0
    for i in range(1, bufnr('$'))
        if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
        "bufno exists AND isn't modified AND isn't in the list of buffers open in windows and tabs
            silent exec 'bwipeout' i
            let nWipeouts = nWipeouts + 1
        endif
    endfor
    echomsg nWipeouts . ' buffer(s) wiped out'
endfunction
" }}}

" Smarter FZF Searching {{{
" Stolen from FZF's repo since it isn't an exported function
function! s:get_git_root()
  if exists('*fugitive#repo')
    try
      return fugitive#repo().tree()
    catch
    endtry
  endif
  let root = split(system('git rev-parse --show-toplevel'), '\n')[0]
  return v:shell_error ? '' : root
endfunction

function! functions#SmartFzfSearching()
    let root = s:get_git_root()
    if empty(root)
        Files
    else
        GFiles
    endif
endfunction
" }}}

" vim: foldlevel=0 foldmethod=marker
