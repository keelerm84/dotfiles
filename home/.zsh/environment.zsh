export TERM=${TERM:-xterm-256color}
export LANG=en_US.UTF-8

export FZF_DEFAULT_OPTS='
    --color fg:223,bg:-1,hl:65,fg+:142,bg+:-1,hl+:108
    --color info:108,prompt:109,spinner:108,pointer:168,marker:168
'
export FZF_CTRL_R_OPTS="--inline-info --exact"

command -v dircolors > /dev/null && eval "$(dircolors ~/.dircolors)"
set -o emacs

[ -e "$HOME/Projects/golang" ] && export GOPATH="$HOME/Projects/golang"
[ -e "/usr/local/go" ] && export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"
[ -e "$HOME/.cask/bin/" ] && export PATH="$PATH:$HOME/.cask/bin/"

[ -e /opt/asdf-vm/asdf.sh ] && . /opt/asdf-vm/asdf.sh
