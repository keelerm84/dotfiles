function dkr-container-name {
    local dir="${PWD##*/}"
    dir="${dir/./}"

    local app=${1:-app}
    __container="$(echo "${dir}" | sed "s/[^a-zA-Z0-9]//")_${app}"
}

function dkr-down {
    docker-compose stop $1
}

function dkr-up {
    docker-compose up --remove-orphans -d $1 && \
        dkr-logs $1
}

function dkr-bash {
    dkr-container-name ${1}

    dkr-exec "${__container}_1" bash
}

function dkr-zsh {
    dkr-container-name ${1}

    dkr-exec "${__container}_1" zsh
}

function dkr-logs {
    docker-compose logs -f --tail ${2:-100} $1 | grep -iE --color=auto '(exception|fatal|error|warning|info|trigger_error)|$'
}

function dkr-reup {
    read -q "reply?Are you sure you'd like to restart ${1:-everything}? "
    echo

    if [[ $reply =~ ^[Yy]$ ]]
    then
        dkr-down $1 && dkr-up $1
    else
        echo "Aborting!"
    fi
}

function dkr-clean {
    dkr-container-name ${1}

    dkr-down $1 && \
        docker-compose rm -f $1 && \
        docker rmi "${__container}"
}

function dkr-proxy {
    mkdir -p ~/.config/nginx-proxy/{html,vhost.d,htpasswd,certs}
    touch ~/.config/nginx-proxy/proxy.conf

    docker stop proxy && \
        docker rm proxy

    docker pull jwilder/nginx-proxy && \
        dkr-run --name proxy -d \
            -p 80:80 \
            -p 443:443 \
            -v /var/run/docker.sock:/tmp/docker.sock:ro \
            -v ~/.config/nginx-proxy/html:/usr/share/nginx/html:rw \
            -v ~/.config/nginx-proxy/proxy.conf:/etc/nginx/conf.d/custom-proxy.conf:ro \
            -v ~/.config/nginx-proxy/vhost.d/:/etc/nginx/vhost.d:rw \
            -v ~/.config/nginx-proxy/htpasswd/:/etc/nginx/htpasswd:ro \
            -v ~/.config/nginx-proxy/certs:/etc/nginx/certs:ro \
            --log-opt max-size=5M \
            --net bridge \
            --label com.github.jrcs.letsencrypt_nginx_proxy_companion.nginx_proxy=true \
            jwilder/nginx-proxy

    docker stop ssl && \
        docker rm ssl

    docker pull jrcs/letsencrypt-nginx-proxy-companion && \
        dkr-run --name ssl -d \
            -e "ACME_CA_URI=https://acme-v01.api.letsencrypt.org/directory" \
            -v /var/run/docker.sock:/var/run/docker.sock:ro \
            -v ~/.config/nginx-proxy/certs:/etc/nginx/certs:rw \
            --volumes-from proxy \
            jrcs/letsencrypt-nginx-proxy-companion
}

