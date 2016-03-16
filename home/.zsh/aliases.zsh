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
alias gsp='git show -p'
alias gp='git pull'
alias gpr='git pull --rebase'
alias gP='git push'
alias gm='git merge'
alias g='git'
alias gg='git grep'

alias dkr-logs="docker-compose logs"
alias dkr-up="docker-compose up -d && dkr-logs"
alias dkr-down="docker-compose stop"
alias dkr-rebuild="docker-compose stop && docker-compose build && dkr-up"
alias dkr-proxy="docker stop proxy && docker rm proxy; docker run --name proxy -d -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock -v ~/.nginx.prof.conf:/etc/nginx/conf.d/proxy.conf:ro -it jwilder/nginx-proxy"

[ -e ~/.aliases.local ] && . ~/.aliases.local || true
