# Convenient function to allow local overrides for all sourced files
function load_file {
    [ -e ~/.zsh/${1} ] && . ~/.zsh/${1} || true
    [ -e ~/.zsh.local/${1} ] && . ~/.zsh.local/${1} || true
}

function man {
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

function git_ignore {
    selections=$(curl -s https://www.gitignore.io/api/list?format=json | \
        jq '.[].name' | \
        fzf -m --prompt='Template> ' | \
        sed 's/^"\(.*\)"$/\1/' | \
        tr '\n' ',' | \
        sed 's/.$//')

    if [ $? -ne 0 ]; then
        exit;
    fi

    if [ -e .gitignore ]; then
        echo "Appending to existing .gitignore file."
    fi

    curl -sLw "\n" "https://www.gitignore.io/api/${selections}" >> .gitignore
}

. ~/.zsh/functions/docker.zsh
