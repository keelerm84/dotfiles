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
        return 1
    fi

    if [ -e .gitignore ]; then
        echo "Appending to existing .gitignore file."
    fi

    curl -sLw "\n" "https://www.gitignore.io/api/${selections}" >> .gitignore
}

function record_gif {
    if [ -z "$1" ]; then
        echo "You must provide a name for the gif"
        return 1
    fi

    local currentDir=$(pwd)

    tmpDir=$(mktemp -d /tmp/gif-recording.XXXXXX)

    if [ $? -ne 0 ]; then
        echo "Failed to create temp dir"
        return 1
    fi

    cd $tmpDir

    if [ $? -ne 0 ]; then
        echo "Failed to change into $tmpDir"
        return 1
    fi

    echo "Click the window to record"
    winInfo=$(xwininfo)

    width=$(echo $winInfo | grep 'Width:' | awk -F: '{ print $2 }')
    height=$(echo $winInfo | grep 'Height:' | awk -F: '{ print $2 }')
    upperLeftX=$(echo $winInfo | grep 'Absolute upper-left X:' | awk -F: '{ print $2 }')
    upperLeftY=$(echo $winInfo | grep 'Absolute upper-left Y:' | awk -F: '{ print $2 }')

    echo "Beginning screen capture. Press [q] when finished"
    ffmpeg -loglevel quiet -f x11grab -video_size ${width}x${height} -framerate 60 -i :0.0+${upperLeftX},${upperLeftY} -c:v ffvhuff screen.mkv

    if [ $? -ne 0 ]; then
        echo "An error occurred capturing video"
        cd -
        return 1
    fi

    echo "Generating palette.png"
    ffmpeg -loglevel quiet -i screen.mkv -vf fps=15,scale=${width}:-1:flags=lanczos,palettegen palette.png

    echo "Converting screen.mkv to ${currentDir}/${1}.gif"
    ffmpeg -loglevel quiet -i screen.mkv -i palette.png -filter_complex "fps=15,scale=${width}:-1:flags=lanczos[x];[x][1:v]paletteuse" ${currentDir}/$1.gif

    cd "$currentDir"
}

function swatch {
    if [[ $# == 0 ]]; then
        echo "Fetch recent logs and follow for new messages. Parameters:"
        echo "  -h|--hours ..... hours of logs in the past to fetch (optional, defaults to 1 hr)"
        echo "  -g|--group ..... log group"
        echo "  -p|--profile ... aws profile"
        echo "  -x|--prefix .... stream prefix"
        return
    fi

    local hours=1
    local group=
    local profile=default
    local prefix=

    while [[ "$#" > 0 ]]; do
        case "${1}" in
            -h|--hours)
                hours=${2}
                shift 2;;
            -g|--group)
                group=${2}
                shift 2;;
            -p|--profile)
                profile=${2}
                shift 2;;
            -x|--prefix)
                prefix=${2}
                shift 2;;
            *)
                shift;; # unexpected params
        esac
    done

    echo "Fetching ${hours}h of ${group} ${prefix} logs using ${profile} profile..."

    if [[ ! -z ${prefix} ]]; then
        prefix=(--prefix "${prefix}")
    fi

    saw --profile ${profile} get ${group} "${prefix[@]}" --pretty --start -${hours}h
    saw --profile ${profile} watch ${group} "${prefix[@]}"
}

function load_nvm () {
    if [ ! -e "$HOME/.nvm" ]; then
        >&2 echo "You do not have nvm installed"
        return
    fi

    command -v nvm > /dev/null
    if [ $? -ne 0 ]; then
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" --no-use
    else
        >&2 echo "nvm already loaded"
    fi
}

function load_rvm () {
    if [ ! -e $HOME/.cache/yay/rvm/rvm.sh ]; then
        >&2 echo "You do not have rvm installed"
        return
    fi

    command -v rvm > /dev/null

    if [ $? -ne 0 ]; then
        . $HOME/.cache/yay/rvm/rvm.sh
    else
        >&2 echo "rvm already loaded"
    fi
}

. ~/.zsh/functions/docker.zsh
