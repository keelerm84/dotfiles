export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export TERM=xterm-256color

export FZF_CTRL_R_OPTS="--inline-info --exact"

if whence dircolors >/dev/null; then
    eval "$(dircolors ~/.dircolors)"
fi

[ -e "$HOME/Projects/golang" ] && export GOPATH="$HOME/Projects/golang"
[ -e "/usr/local/go" ] && export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"
[ -e "$HOME/.cask/bin/" ] && export PATH="$PATH:$HOME/.cask/bin/"
