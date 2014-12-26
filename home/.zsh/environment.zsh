export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

source ~/.xinitrc 2> /dev/null

[ -e ~/.rvm ] && rvm reset > /dev/null 2>&1
