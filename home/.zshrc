. ~/.zsh/functions.zsh

. ~/.zsh/git.zsh
. ~/.zsh/themes/gitster.zsh
load_file "functions.zsh"
load_file "environment.zsh"
load_file "setopt.zsh"
load_file "exports.zsh"
load_file "completion.zsh"
load_file "bindkeys.zsh"
load_file "aliases.zsh"
load_file "history.zsh"

[ -e ~/.zshrc.local ] && . ~/.zshrc.local || true

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
