 . /usr/lib/python3.3/site-packages/powerline/bindings/zsh/powerline.zsh

. ~/.zsh/setopt.zsh
. ~/.zsh/exports.zsh
. ~/.zsh/completion.zsh
. ~/.zsh/bindkeys.zsh
. ~/.zsh/aliases.zsh
. ~/.zsh/history.zsh

[ -e ~/.zshrc.local ] && . ~/.zshrc.local || true

[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && . $HOME/.tmuxinator/scripts/tmuxinator || true
