set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

let files = ["~/.vim/config/bundles", "~/.vim/config/functions", "~/.vim/config/mappings", "~/.vim/config/environment", "~/.vim.bundles.local", "~/.vim.local"]

for file in files
  if filereadable(expand(file))
    execute "source " . file
  endif
endfor

filetype plugin indent on
call InitializeDirectories()
highlight clear SignColumn
