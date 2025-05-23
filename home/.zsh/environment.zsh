command -v xset > /dev/null && [ -n "$DISPLAY" ] && xset r rate 500 25
command -v nvim > /dev/null && export EDITOR=nvim || export EDITOR=vim
command -v nvim > /dev/null && export MANPAGER="$EDITOR +Man!" || export MANPAGER="vim -c MANPAGER -"

export SAM_CLI_TELEMETRY=0
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export MLDOTNET_CLI_TELEMETRY_OPTOUT=1

export MYSQL_PS1="mysql  \d  \R:\m:\s  "
export VIRTUAL_ENV_DISABLE_PROMPT=1
export BAT_THEME="Solarized (dark)"

export TERM=${TERM:-xterm-256color}
export LANG=en_US.UTF-8

export FZF_DEFAULT_OPTS='
    --color fg:223,bg:-1,hl:65,fg+:142,bg+:-1,hl+:108
    --color info:108,prompt:109,spinner:108,pointer:168,marker:168
'
export FZF_CTRL_R_OPTS="--inline-info --exact"

command -v dircolors > /dev/null && eval "$(dircolors ~/.dircolors)"

export ANDROID_HOME="$HOME/Android/Sdk"

paths=(
  "/usr/local/go/bin"
  "/usr/share/dotnet"
  "/var/lib/snapd/snap/bin/"
  "$HOME/.asdf/shims"
  "$HOME/.cabal/bin"
  "$HOME/.cask/bin/"
  "$HOME/.cargo/bin"
  "$HOME/.ghcup/bin"
  "$HOME/.bin"
  "$HOME/.local/bin"
  "$HOME/.local/share/JetBrains/Toolbox/scripts/"
  "$HOME/.local/share/nvim/mason/bin/"
  "$HOME/.pub-cache/bin"
  "$HOME/.yarn/bin"
  "$HOME/go/bin"
  "$ANDROID_HOME/platform-tools/"
  "$ANDROID_HOME/emulator/"
  "$ANDROID_HOME/cmdline-tools/latest/bin/"
)

for p ("$paths[@]") [[ -e "$p" ]] && export PATH="$p:$PATH"

if [ -e "$HOME/code/golang" ]; then
  export GOPATH="$HOME/code/golang"
  export PATH="$GOPATH/bin:$PATH"
fi

[ -e /opt/asdf-vm/asdf.sh ] && . /opt/asdf-vm/asdf.sh
command -v rbenv > /dev/null && eval "$(rbenv init -)"

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null && eval "$(pyenv init -)"

[[ ! -r $HOME/.opam/opam-init/init.zsh ]] || source $HOME/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && . $HOME/.tmuxinator/scripts/tmuxinator || true
[[ -f $HOME/.homesick/repos/homeshick/homeshick.sh ]] && . $HOME/.homesick/repos/homeshick/homeshick.sh || true
