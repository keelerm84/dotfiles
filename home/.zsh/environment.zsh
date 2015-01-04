export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

source ~/.xinitrc 2> /dev/null

[ -e "$HOME/Projects/golang" ] && export GOPATH="$HOME/Projects/golang"
[ -e "/usr/local/go" ] && export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"
