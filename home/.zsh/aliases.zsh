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
alias gll='g ll'
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
alias dkr-logs="docker-compose logs -f"
alias dkr-reup="dkr-down && dkr-up"
alias dkr-stats="docker stats \$(docker ps --format '{{.Names}}')"
alias dkr-up="docker-compose up -d && dkr-logs"
alias dkr-update="docker images | awk '{print \$1}' | xargs -L1 docker pull"
alias dkr-mysql="dkr-exec \$(docker-compose ps -q mysql) mysql"

alias dkr-proxy="docker stop proxy && docker rm proxy; docker run --name proxy -d -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock -v ~/.nginx.prof.conf:/etc/nginx/conf.d/proxy.conf:ro --net bridge -it jwilder/nginx-proxy"
alias dkr-nginx-proxy="docker stop proxy && docker rm proxy; docker pull jwilder/nginx-proxy && docker run --name proxy -d -p 80:80 -p 443:443 -v /var/run/docker.sock:/tmp/docker.sock:ro -v ~/.config/nginx-proxy/html:/usr/share/nginx/html:rw -v ~/.config/nginx-proxy/proxy.conf:/etc/nginx/conf.d/proxy.conf:ro -v ~/.config/nginx-proxy/vhost.d/:/etc/nginx/vhost.d:rw -v ~/.config/nginx-proxy/htpasswd/:/etc/nginx/htpasswd:ro -v ~/.config/nginx-proxy/certs:/etc/nginx/certs:ro --log-opt max-size=1M --net bridge --label com.github.jrcs.letsencrypt_nginx_proxy_companion.nginx_proxy=true jwilder/nginx-proxy"
alias dkr-ssl="docker stop ssl && docker rm ssl; docker pull jrcs/letsencrypt-nginx-proxy-companion && docker run --name ssl -d -v /var/run/docker.sock:/var/run/docker.sock:ro -v ~/.config/nginx-proxy/certs:/etc/nginx/certs:rw --volumes-from proxy jrcs/letsencrypt-nginx-proxy-companion"
alias dkr-proxy="dkr-nginx-proxy && dkr-ssl"

alias nvidia-dkr-logs="nvidia-docker-compose logs -f | grep -iE --color=auto '(exception|fatal|error|warning|info|trigger_error)|$'"
alias nvidia-dkr-exec='nvidia-docker exec -it --detach-keys "ctrl-q,q" '
alias nvidia-dkr-run='nvidia-docker run -it --detach-keys "ctrl-q,q" '
alias nvidia-dkr-up="nvidia-docker-compose pull && nvidia-docker-compose up -d --remove-orphans && dkr-logs"
alias nvidia-dkr-down="nvidia-docker-compose stop"
alias nvidia-dkr-reup="nvidia-dkr-down && dkr-up"
alias nvidia-dkr-build='nvidia-dkr-down && nvidia-docker-compose rm && nvidia-docker rmi $(echo "${${PWD##*/}/./}_app" | sed "s/[^a-zA-Z0-9_]//g"); nvidia-docker-compose build --no-cache && nvidia-dkr-up'
alias nvidia-dkr-stats="nvidia-docker stats \$(nvidia-docker ps --format '{{.Names}}')"
alias nvidia-dkr-update="nvidia-docker images | awk '{print \$1}' | xargs -L1 nvidia-docker pull"

[ -e ~/.aliases.local ] && . ~/.aliases.local || true
