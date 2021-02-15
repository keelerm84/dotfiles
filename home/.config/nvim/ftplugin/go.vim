let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

let g:go_fmt_command = "goimports"
let g:go_metalinter_command = "golangci-lint"

let b:noStripWhitespace=1
" FIXME(mmk) Make shouldn't be within go and why do we need qf?
" autocmd FileType qf let b:noStripWhitespace=1
" autocmd FileType make let b:noStripWhitespace=1

nnoremap <buffer> <Leader>r <Plug>(go-run)
nnoremap <buffer> <Leader>e <Plug>(go-rename)
nnoremap <buffer> <Leader>i <Plug>(go-implements)
nnoremap <buffer> <Leader>l :GoMetaLinter<CR>
nnoremap <buffer> <Leader>t <Plug>(go-test)
nnoremap <buffer> <Leader>c <Plug>(go-coverage)
nnoremap <buffer> <Leader>gv <Plug>(go-vet)
nnoremap <buffer> <Leader>gd <Plug>(go-doc)
