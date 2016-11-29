# Convenient function to allow local overrides for all sourced files
function load_file() {
    [ -e ~/.zsh/${1} ] && . ~/.zsh/${1} || true
    [ -e ~/.zsh.local/${1} ] && . ~/.zsh.local/${1} || true
}

man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}

function dkr-bash {
    dir="${PWD##*/}"
    dir="${dir/./}"
    container=$(echo "${dir}_app_1" | sed "s/[^[:alpha:]^[:digit:]_]//")
    docker exec -it --detach-keys 'ctrl-q,q' "${container}" bash
}

function dkr-zsh {
    dir="${PWD##*/}"
    dir="${dir/./}"
    container=$(echo "${dir}" | sed "s/[^[:alpha:][:digit:]_]//g")
    docker exec -it --detach-keys 'ctrl-q,q' "${container}_app_1" zsh
}
