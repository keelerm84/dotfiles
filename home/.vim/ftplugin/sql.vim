" TODO(mmk) Make a note that sqlformat is a required external program
setlocal commentstring=--\ %s
vnoremap <leader>sf :'<,'>!sqlformat -a -k upper -s --wrap_after 79 -<CR>
nnoremap <leader>sf :.!sqlformat -a -k upper -s --wrap_after 79 -<CR>
