function dkr-container-name {
    __params=(${@[@]})

    # extract the container name
    for __var in "$@"; do
        if [[ $__var != \-* ]]; then
            __container="$__var"
            break
        fi
    done

    # Replace the container name with the original if not a docker-compose project
    __is_compose=false
    if [[ -f ./docker-compose.yml && "$__var" == "" ]]; then
        __is_compose=true
    elif [[ ! -f ./docker-compose.yml || "$(docker-compose ps | grep $__var)" == "" ]]; then
        __container="$__var"
    else
        __is_compose=true
    fi

    # Swap out the container name from the copy
    for ((i=0; i < ${#__params[@]}; ++i)); do
        if [[ "${__params[$i]}" == "$__var" ]]; then
            __params[$i]="$__container"
        fi
    done
}

function dkr-exec {
    dkr-container-name $@

    local cmd="docker"
    local it="-it"
    if [[ $__is_compose == true ]]; then
        cmd="docker-compose"
        it=""
    fi

    # echo "Running: ${cmd} exec -e COLUMNS=\"`tput cols`\" -e LINES=\"`tput lines`\" ${it} ${__params[@]}"
    ${cmd} exec -e COLUMNS="`tput cols`" -e LINES="`tput lines`" ${it} ${__params[@]}
}

function dkr-run {
    dkr-container-name $@

    local cmd="docker"
    local it="-it"
    if [[ $__is_compose == true ]]; then
        cmd="docker-compose"
        it=""
    fi

    # echo "Running: ${cmd} run -e COLUMNS=\"`tput cols`\" -e LINES=\"`tput lines`\" ${it} ${__params[@]}"
    ${cmd} run -e COLUMNS="`tput cols`" -e LINES="`tput lines`" ${it} ${__params[@]}
}

function dkr-stats {
    if [[ "$1" != "" ]]; then
        dkr-container-name $1
    fi

    __containers="$1"

    # If inside a docker-compose project
    if [[ -z $__container || "$(docker ps | grep $__container)" != "" ]]; then
        __containers="${__container}"
    fi

    # If not inside a docker-compose project and no container is requested, use all
    if [[ "$__containers" == "" ]]; then
        __containers="$(docker ps --format '{{.Names}}')"
    fi

    docker stats $(echo "$__containers")
}

function dkr-down {
    docker-compose stop $1
}

function dkr-up {
    docker-compose up --remove-orphans -d $1 && \
        dkr-logs $1
}

function dkr-bash {
    if [[ -z $1 ]]; then
        1=app
    fi

    dkr-exec "$1" bash
}

function dkr-zsh {
    if [[ -z $1 ]]; then
        1=app
    fi

    dkr-exec "$1" zsh
}

function dkr-logs {
    dkr-container-name $@

    local cmd="docker"
    if [[ $__is_compose == true ]]; then
        cmd="docker-compose"
    fi

    # echo "Running: ${cmd} logs -f --tail ${2:-100} ${__params[@]} | grep -iE --color=auto '(exception|fatal|error|warning|info|trigger_error)|$'"
    ${cmd} logs -f --tail ${2:-100} ${__params[@]} | grep -iE --color=auto '(exception|fatal|error|warning|info|trigger_error)|$'
}

function dkr-reup {
    read -q "reply?Are you sure you'd like to stop and start ${1:-everything}? "
    echo

    if [[ $reply =~ ^[Yy]$ ]]
    then
        dkr-down $1 && dkr-up $1
    else
        echo "Aborting!"
    fi
}

function dkr-restart {
    read -q "reply?Are you sure you'd like to restart ${1:-everything}? "
    echo

    if [[ $reply =~ ^[Yy]$ ]]
    then
        docker-compose restart $1
        dkr-logs $1
    else
        echo "Aborting!"
    fi
}

function dkr-clean {
    dkr-container-name $1

    dkr-down $1 && \
        docker-compose rm -f $1 && \
        docker rmi "$__container"
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

