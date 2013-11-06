#allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD

## keep background processes at full speed
setopt NOBGNICE

## restart running processes on exit
setopt HUP

## never ever beep ever
setopt NO_BEEP

setopt complete_in_word
setopt always_to_end

setopt auto_cd
setopt auto_name_dirs
setopt auto_pushd
setopt pushd_silent

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data

setopt PROMPT_SUBST # Enable prompt expansion
