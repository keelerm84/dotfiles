# zmodload zsh/zprof

. ~/.zsh/functions.zsh

. ~/.zsh/git.zsh
command -v starship >/dev/null && eval "$(starship init zsh)" || . ~/.zsh/themes/spaceship.zsh
load_file "aliases.zsh"
load_file "functions.zsh"
load_file "environment.zsh"
load_file "setopt.zsh"
load_file "completion.zsh"
load_file "history.zsh"

[ -e ~/.zshrc.local ] && . ~/.zshrc.local || true

command -v fzf >/dev/null && source <(fzf --zsh) || true

# # Moved down so I can remap some of the fzf bindings
load_file "bindkeys.zsh"
