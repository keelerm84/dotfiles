autocmd BufNewFile,BufRead fugitive://* set bufhidden=delete

nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Git commit<CR>
nnoremap <silent> <leader>gb :Git blame<CR>
nnoremap <silent> <leader>gl :Gclog<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>:GitGutter<CR>
