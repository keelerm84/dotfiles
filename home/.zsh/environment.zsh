command -v xset > /dev/null && [ -n "$DISPLAY" ] && xset r rate 500 25

export TERM=${TERM:-xterm-256color}
export LANG=en_US.UTF-8

export FZF_DEFAULT_OPTS='
    --color fg:223,bg:-1,hl:65,fg+:142,bg+:-1,hl+:108
    --color info:108,prompt:109,spinner:108,pointer:168,marker:168
'
export FZF_CTRL_R_OPTS="--inline-info --exact"

command -v dircolors > /dev/null && eval "$(dircolors ~/.dircolors)"
set -o emacs

paths=(
    "/usr/local/go/bin"
    "$HOME/code/golang"
    "$HOME/go/bin"
    "$HOME/.ghcup/bin"
    "$HOME/.cask/bin/"
    "$HOME/.local/bin"
    "$HOME/go/bin"
    "$HOME/.local/share/nvim/mason/bin/"
    "$HOME/Android/Sdk/platform-tools/"
    "$HOME/Android/Sdk/emulator/"
    "$HOME/.local/share/JetBrains/Toolbox/scripts/"
)

for p ("$paths[@]") [[ -e "$p" ]] && export PATH="$p:$PATH"

[ -e "$HOME/code/golang" ] && export GOPATH="$HOME/code/golang"
[ -e "$HOME/Android/Sdk" ] && export ANDROID_SDK_ROOT="$HOME/Android/Sdk"
[ -e /opt/asdf-vm/asdf.sh ] && . /opt/asdf-vm/asdf.sh
command -v rbenv > /dev/null && eval "$(rbenv init -)"
