bindkey -e ## Default to standard emacs bindings

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

