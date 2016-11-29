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

alias dkr-build='dkr-down && docker-compose rm -f && docker rmi $(echo "${${PWD##*/}/./}_app" | sed "s/[^a-zA-Z0-9_]//g"); docker-compose build && dkr-up'
alias dkr-down="docker-compose stop"
alias dkr-exec='docker exec -it --detach-keys "ctrl-q,q" '
alias dkr-logs="docker-compose logs"
alias dkr-proxy="docker stop proxy && docker rm proxy; docker run --name proxy -d -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock -v ~/.nginx.prof.conf:/etc/nginx/conf.d/proxy.conf:ro --net bridge -it jwilder/nginx-proxy"
alias dkr-reup="dkr-down && dkr-up"
alias dkr-stats="docker stats \$(docker ps --format '{{.Names}}')"
alias dkr-up="docker-compose up -d && dkr-logs"
alias dkr-update="docker images | awk '{print \$1}' | xargs -L1 docker pull"

[ -e ~/.aliases.local ] && . ~/.aliases.local || true
