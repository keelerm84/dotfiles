let g:php_manual_online_search_shortcut = '<Leader>K'
let g:pdv_template_dir = $HOME."/.vim/plugins/pdv/templates_snip"

setlocal tabstop=4
setlocal shiftwidth=4 foldlevel=1
setlocal commentstring=//\ %s
setlocal omnifunc=phpactor#Complete

nnoremap <Leader>pd :call pdv#DocumentWithSnip()<CR>
nnoremap <Leader>pcf :call PhpCsFixerFixFile()<CR>

nnoremap <buffer> <Leader>u :call phpactor#UseAdd()<CR>
nnoremap <buffer> <Leader>mm :call phpactor#ContextMenu()<CR>
nnoremap <buffer> <Leader>nn :call phpactor#Navigate()<CR>
nnoremap <buffer> <Leader>o :call phpactor#GotoDefinition()<CR>
nnoremap <buffer> <Leader>ft :call phpactor#Transform()<CR>
nnoremap <buffer> <Leader>cc :call phpactor#ClassNew()<CR>
nnoremap <buffer> <silent><Leader>ee :call phpactor#ExtractExpression(v:false)<CR>
vnoremap <buffer> <silent><Leader>ee :<C-U>call phpactor#ExtractExpression(v:true)<CR>
vnoremap <silent><Leader>em :<C-U>call phpactor#ExtractMethod()<CR>
