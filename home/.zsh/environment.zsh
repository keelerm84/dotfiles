export TERM=${TERM:-xterm-256color}
export LANG=en_US.UTF-8

export FZF_CTRL_R_OPTS="--inline-info --exact"

command -v dircolors > /dev/null && eval "$(dircolors ~/.dircolors)"

[ -e "$HOME/Projects/golang" ] && export GOPATH="$HOME/Projects/golang"
[ -e "/usr/local/go" ] && export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"
[ -e "$HOME/.cask/bin/" ] && export PATH="$PATH:$HOME/.cask/bin/"
