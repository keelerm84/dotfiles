alias homesick="~/.homeshick"
alias tmux='tmux -2 -u'
alias e='emacsclient -t'
alias E="SUDO_EDITOR=\"emacsclient -t -a emacs\" sudoedit"

alias gr='[ ! -z `git rev-parse --show-toplevel` ] && cd `git rev-parse --show-toplevel || pwd`'
alias gb='git branch'
alias gdc='git diff --cached'
alias gd='git diff'
alias gap='git add -p'
alias ga='git add'
alias gc='git commit --verbose'
alias gca='gc --amend'
alias gco='git checkout'
alias gl='git log'
alias gs='git status'
alias gp='git pull'
alias gpr='git pull --rebase'
alias gP='git push'
alias gm='git merge'
alias g='git'
alias gg='git grep'

[ -e ~/.aliases.local ] && . ~/.aliases.local || true
