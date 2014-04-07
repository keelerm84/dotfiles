alias homesick="~/.homeshick"
alias tmux='tmux -2 -u'
alias ec='emacsclient -c'
alias gr='[ ! -z `git rev-parse --show-toplevel` ] && cd `git rev-parse --show-toplevel || pwd`'

[ -e ~/.aliases.local ] && . ~/.aliases.local || true
