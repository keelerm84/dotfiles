bindkey -e ## Default to standard emacs bindings

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# M-. let's me grab the last argument on the previous line.  M-m let's me cycle through them.
autoload -Uz copy-earlier-word
zle -N copy-earlier-word
bindkey "^[m" copy-earlier-word

autoload -U select-word-style
select-word-style bash
