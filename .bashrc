
# If not running interactively, don't do anything
[[ $- != *i* ]] && return


## Aliases ##

# Turns on colors for `ls` only if connected to a terminal
alias ls='ls --color=auto'

# Turns on colors for `grep` only if connected to a terminal
alias grep='grep --color=auto'


## Bash settings ##

# Append lines to the .bash_history file, instead of overwriting it
shopt -s histappend


## Exported variables ##

export EDITOR=$(which vim)


## Prompt coloring ##

function build_ps1() {
  # Resets escape sequnce
  local reset='\e[m'

  # Bold colors
  local b_cyan='\e[1;36m'

  # High intensity bold colors
  local bi_red='\e[1;91m'
  local bi_green='\e[1;92m'
  local bi_blue='\e[1;94m'

  # High intensity colors
  local i_white='\e[0;97m'

  local user_color="${bi_blue}"
  local prompt_color="${bi_green}"
  # Change prompt color to red if running as root
  if [[ ${UID} -eq 0 ]] ; then
    local user_color="${bi_red}"
    local prompt_color="${bi_red}"
  fi

  local lb="\[${White}\][\[${reset}\]"
  local rb="\[${White}\]]\[${reset}\]"
  local user="\[${user_color}\]\u\[${reset}\]"
  local host="\[${user_color}\]\h\[${reset}\]"
  local path="\[${bi_green}\]\w\[${reset}\]"
  local prompt="\[${prompt_color}\]\\$\[${reset}\]\[${i_white}\]"

  # Finally build the command prompt
  echo "${lb} ${user}@${host} ${rb}${lb} ${path} ${rb} ${prompt} "
}

export PS1="$(build_ps1)"


## Man pages coloring ##

man() {
  local b_cyan='\e[1;36m'

  LESS_TERMCAP_mb=$(printf "${b_cyan}") \
  LESS_TERMCAP_md=$(printf "${b_cyan}") \
  LESS_TERMCAP_me=$'\e[0m' \
  LESS_TERMCAP_se=$'\e[0m' \
  LESS_TERMCAP_so=$'\e[01;44;33m' \
  LESS_TERMCAP_ue=$'\e[0m' \
  LESS_TERMCAP_us=$'\e[01;32m' \
  command man "$@"
}

