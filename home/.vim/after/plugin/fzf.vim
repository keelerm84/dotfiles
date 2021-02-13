nnoremap <silent> <C-p> :call functions#SmartFzfSearching()<CR>
nnoremap <silent> g<C-p> :Files<CR>
nnoremap <silent> gs<C-p> :GFiles?<CR>

nnoremap <silent> <leader>T :BTags<CR>
nnoremap <silent> g<leader>T :Tags<CR>

nnoremap <silent> <leader>l :BLines<CR>
nnoremap <silent> g<leader>l :Lines<CR>

nnoremap <silent> <leader>b :Buffers<CR>

nnoremap <silent> <leader>c :BCommits<CR>
nnoremap <silent> g<leader>c :Commits<CR>

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

