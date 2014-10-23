alias homesick="~/.homeshick"
alias tmux='tmux -2 -u'
alias ec='emacsclient -c'


alias gr='[ ! -z `git rev-parse --show-toplevel` ] && cd `git rev-parse --show-toplevel || pwd`'
alias gdc='git diff --cached'
alias gd='git diff'
alias gap='git add -p'
alias ga='git add'
alias ci='git commit'
alias cia='git commit --amend'
alias gs='git status'

[ -e ~/.aliases.local ] && . ~/.aliases.local || true
