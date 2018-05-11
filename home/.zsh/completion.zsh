autoload -U compinit
compinit

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

## automatically decide when to page a list of completions
LISTMAX=0

zstyle ':completion:*' list-colors ''

## Allow completion of ..
zstyle ':completion:*' special-dirs true

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
cdpath=(.)

# use /etc/hosts and known_hosts for hostname completion
[ -r ~/.ssh/known_hosts ] && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
[ -r ~/.ssh/config ] && _ssh_config=($(cat ~/.ssh/config | sed -ne 's/Host[=\t ]//p')) || _ssh_config=()
[ -r /etc/hosts ] && : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}} || _etc_hosts=()

hosts=(
  "$_ssh_config[@]"
  "$_ssh_hosts[@]"
  "$_etc_hosts[@]"
  "$HOST"
  localhost
)
zstyle ':completion:*:hosts' hosts $hosts
zstyle ':completion:*' users off

# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH/cache/

zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes
