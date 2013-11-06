. ~/.zsh/functions.zsh

. ~/.zsh/git.zsh
. ~/.zsh/agnoster.zsh-theme
load_file "setopt.zsh"
load_file "exports.zsh"
load_file "completion.zsh"
load_file "bindkeys.zsh"
load_file "aliases.zsh"
load_file "history.zsh"

[ -e ~/.zshrc.local ] && . ~/.zshrc.local || true
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && . $HOME/.tmuxinator/scripts/tmuxinator || true
