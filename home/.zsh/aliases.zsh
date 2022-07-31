if [[ "$(uname -s)" == "Darwin" ]]; then
    alias ls="ls -G"
else
    alias ls="ls -N --color=auto"
fi

alias l="ls -lhF"
alias ll="ls -alhF"
alias tmux='tmux -2 -u'
alias tl='tmux list-sessions'
alias e='emacsclient -t'
alias E="SUDO_EDITOR=\"emacsclient -t -a emacs\" sudoedit"

alias g='git'

alias gwc='g whatchanged'

alias gwt='g worktree'
alias gwtl='gwt list'
alias gwta='gwt add'
alias gwtr='gwt remove'

alias gr='[ ! -z `git rev-parse --show-toplevel` ] && cd `g rev-parse --show-toplevel || pwd`'
alias gb='g branch'

alias gd='g diff'
alias gdc='gd --cached'

alias gf='g fetch'

alias ga='g add'
alias gap='ga -p'
alias gau='ga --update'

alias gc='g commit --verbose'
alias gca='gc --amend'
alias gcan='gc --amend --no-edit'

alias gco='g checkout'
alias grs='g restore --staged'

alias gl='g log'
alias gll='g ll'

alias gs='g status'
alias gsp='g show -p'

alias gp='g pull'
alias gpr='gp --rebase'

alias gra='g rebase --abort'
alias grc='g rebase --continue'

alias gP='g push'
alias gPf='g push --force-with-lease'
alias gm='g merge'

alias gg='g grep'

alias gst='g stash'
alias gstl='gst list'
alias gstd='gst drop'
alias gstp='gst pop'
alias gsta='gst apply'
alias gsts='gst save'
alias gstsp='gst show -p'
alias gstsu='gsts -u'

alias dpss='docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Ports}}" | sort -k2'

alias mutt='TERM=xterm-256color neomutt'
alias mux=tmuxinator
