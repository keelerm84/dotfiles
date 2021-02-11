let g:php_manual_online_search_shortcut = '<Leader>K'
let g:pdv_template_dir = $HOME."/.vim/plugins/pdv/templates_snip"

setlocal tabstop=4
setlocal shiftwidth=4 foldlevel=1
setlocal commentstring=//\ %s
setlocal omnifunc=phpactor#Complete

nnoremap <Leader>pd :call pdv#DocumentWithSnip()<CR>
nnoremap <Leader>pcf :call PhpCsFixerFixFile()<CR>

" Include use statement
nnoremap <buffer> <Leader>u :call phpactor#UseAdd()<CR>

" Invoke the context menu
nnoremap <buffer> <Leader>mm :call phpactor#ContextMenu()<CR>

" Invoke the navigation menu
nnoremap <buffer> <Leader>nn :call phpactor#Navigate()<CR>

" Goto definition of class or class member under the cursor
nnoremap <buffer> <Leader>o :call phpactor#GotoDefinition()<CR>

" Transform the classes in the current file
nnoremap <buffer> <Leader>ft :call phpactor#Transform()<CR>

" Generate a new class (replacing the current file)
nnoremap <buffer> <Leader>cc :call phpactor#ClassNew()<CR>

" Extract expression (normal mode)
nnoremap <buffer> <silent><Leader>ee :call phpactor#ExtractExpression(v:false)<CR>

" Extract expression from selection
vnoremap <buffer> <silent><Leader>ee :<C-U>call phpactor#ExtractExpression(v:true)<CR>

" Extract method from selection
vnoremap <silent><Leader>em :<C-U>call phpactor#ExtractMethod()<CR>
