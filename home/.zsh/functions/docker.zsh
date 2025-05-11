function dkr-container-name {
    __params=(${@[@]})

    local __var=""
    __container=""

    # extract the container name
    for __var in "$@"; do
        if [[ $__var != \-* ]]; then
            __container="$__var"
            break
        fi
    done

    # Replace the container name with the original if not a docker compose project
    __is_compose=false
    if [[ -f ./docker-compose.yml && "$__var" == "" ]]; then
        __is_compose=true
    elif [[ ! -f ./docker-compose.yml ]] || ! grep -q $(echo $__var | awk '{print $1;}') ./docker-compose.yml; then
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

    local cmd=( docker )
    local it="-it"
    if [[ $__is_compose == true ]]; then
        cmd=( docker compose )
        it=""
    fi

    echo "Running: ${cmd} exec -e COLUMNS=\"`tput cols`\" -e LINES=\"`tput lines`\" ${it} ${__params[@]}"
    ${cmd[@]} exec -e COLUMNS="`tput cols`" -e LINES="`tput lines`" ${it} ${__params[@]}
}

function dkr-run {
    dkr-container-name $@

    local cmd=( docker )
    local it="-it"
    if [[ $__is_compose == true ]]; then
        cmd=( docker compose )
        it=""

        if [[ "$(docker compose ps | grep -q $__container)" -eq "" ]]; then
            echo "Running: ${cmd} up --no-start --no-recreate --remove-orphans $__container"
            ${cmd[@]} up --no-start --no-recreate --remove-orphans $__container
        fi
    fi

    echo "Running: ${cmd[@]} run -e COLUMNS=\"`tput cols`\" -e LINES=\"`tput lines`\" ${it} ${__params[@]}"
    ${cmd[@]} run -e COLUMNS="`tput cols`" -e LINES="`tput lines`" ${it} ${__params[@]}
}

function dkr-stats {
    dkr-container-name $1
    __containers="$argv"

    # If inside a docker-compose project
    if [[ $__is_compose == true ]]; then
        if [[ ! -z "$argv" ]]; then
            __containers="$(docker compose ps | grep running | grep $(echo $argv | sed 's# #\\|#') | awk '{ print $1 }')"
        else
            __containers="$(docker compose ps | grep running | awk '{ print $1 }')"
        fi
    fi

    # If not inside a docker compose project and no container is requested, use all
    if [[ "$__containers" == "" ]]; then
        __containers="$(docker ps --format '{{.Names}}')"
    fi

    docker stats $(echo "$__containers")
}

function dkr-up {
    docker compose up --no-recreate --remove-orphans --detach ${=1} && \
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
        cmd="docker compose"
    fi

    echo "Running: ${cmd} logs -f --tail ${2:-100} ${__params[@]} | grep -aiE --color=auto '(exception|fatal|error|warning|info|trigger_error)|$'"
    ${=cmd} logs --follow --tail ${2:-100} ${=__params} | grep -aiE --color=auto '(exception|fatal|error|warning|info|trigger_error)|$'
}
