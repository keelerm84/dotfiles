nnoremap <C-p> :call functions#SmartFzfSearching()<CR>
nnoremap g<C-p> :Files<CR>
nnoremap gs<C-p> :GFiles?<CR>

nnoremap <leader>T :BTags<CR>
nnoremap g<leader>T :Tags<CR>

nnoremap <leader>l :BLines<CR>
nnoremap g<leader>l :Lines<CR>

nnoremap <leader>b :Buffers<CR>

nnoremap <leader>c :BCommits<CR>
nnoremap g<leader>c :Commits<CR>

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-h': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
let g:fzf_preview_window = ['right:50%:hidden', 'ctrl-o']
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'GruvboxAqua'],
  \ 'fg+':     ['fg', 'String'],
  \ 'bg+':     ['bg', 'Normal'],
  \ 'hl+':     ['fg', 'GruvboxBlue'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Comment'],
  \ 'prompt':  ['fg', 'GruvboxPurple'],
  \ 'pointer': ['fg', 'GruvboxPurple'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

