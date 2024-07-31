return {
  "preservim/tagbar",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    vim.cmd([[
          let g:tagbar_type_haskell = {
            \ 'ctagsbin'  : 'hasktags',
            \ 'ctagsargs' : '-x -c -o-',
            \ 'kinds'     : [
                \  'm:modules:0:1',
                \  'd:data: 0:1',
                \  'd_gadt: data gadt:0:1',
                \  't:type names:0:1',
                \  'nt:new types:0:1',
                \  'c:classes:0:1',
                \  'cons:constructors:1:1',
                \  'c_gadt:constructor gadt:1:1',
                \  'c_a:constructor accessors:1:1',
                \  'ft:function types:1:1',
                \  'fi:function implementations:0:1',
                \  'i:instance:0:1',
                \  'o:others:0:1'
            \ ],
            \ 'sro'        : '.',
            \ 'kind2scope' : {
                \ 'm' : 'module',
                \ 'c' : 'class',
                \ 'd' : 'data',
                \ 't' : 'type',
                \ 'i' : 'instance'
            \ },
            \ 'scope2kind' : {
                \ 'module'   : 'm',
                \ 'class'    : 'c',
                \ 'data'     : 'd',
                \ 'type'     : 't',
                \ 'instance' : 'i'
            \ }
          \ }
          let g:tagbar_type_ruby = {
            \ 'kinds' : [
            \ 'm:modules',
            \ 'c:classes',
            \ 'd:describes',
            \ 'C:contexts',
            \ 'i:things described with "it"',
            \ 'f:methods',
            \ 'F:singleton methods'
            \ ]
            \ }
        ]])

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>tt", ":TagbarOpen fj<CR>", { desc = "Open tagbar" })
    keymap.set("n", "<leader>tc", ":TagbarClose<CR>", { desc = "Close tagbar" })
  end,
}
