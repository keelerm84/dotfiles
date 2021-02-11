let g:OmniSharp_timeout = 5
let g:OmniSharp_highlight_types = 3

augroup csharp
    autocmd!
    " Show type information automatically when the cursor stops moving.
    " Note that the type is echoed to the Vim command line, and will overwrite
    " any other messages in this space including e.g. ALE linting messages.
    autocmd CursorHold *.cs OmniSharpTypeLookup
augroup END

" The following commands are contextual, based on the cursor position.
nnoremap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
nnoremap <silent> <buffer> <Leader>osfu <Plug>(omnisharp_find_usages)
nnoremap <silent> <buffer> <Leader>osfi <Plug>(omnisharp_find_implementations)
nnoremap <silent> <buffer> <Leader>ospd <Plug>(omnisharp_preview_definition)
nnoremap <silent> <buffer> <Leader>ospi <Plug>(omnisharp_preview_implementations)
nnoremap <silent> <buffer> <Leader>ost <Plug>(omnisharp_type_lookup)
nnoremap <silent> <buffer> K <Plug>(omnisharp_documentation)
nnoremap <silent> <buffer> <Leader>osfs <Plug>(omnisharp_find_symbol)
nnoremap <silent> <buffer> <Leader>osfx <Plug>(omnisharp_fix_usings)
nnoremap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
inoremap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

" Navigate up and down by method/property/field
nnoremap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
nnoremap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)
" Find all code errors/warnings for the current solution and populate the quickfix window
nnoremap <silent> <buffer> <Leader>osgcc <Plug>(omnisharp_global_code_check)
" Contextual code actions (uses fzf, vim-clap, CtrlP or unite.vim selector when available)
nnoremap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
xnoremap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
" Repeat the last code action performed (does not use a selector)
nnoremap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)
xnoremap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)

nnoremap <silent> <buffer> <Leader>os= <Plug>(omnisharp_code_format)

nnoremap <silent> <buffer> <Leader>osnm <Plug>(omnisharp_rename)

nnoremap <silent> <buffer> <Leader>osre <Plug>(omnisharp_restart_server)
nnoremap <silent> <buffer> <Leader>osst <Plug>(omnisharp_start_server)
nnoremap <silent> <buffer> <Leader>ossp <Plug>(omnisharp_stop_server)
