# Convenient function to allow local overrides for all sourced files
function load_file() {
  [ -e ~/.zsh/${1} ] && . ~/.zsh/${1} || true
  [ -e ~/.zsh.local/${1} ] && . ~/.zsh.local/${1} || true
}
