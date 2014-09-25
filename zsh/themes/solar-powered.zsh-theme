
load_glyphs() {
  # Solarized colors
  BASE03="%{$FG[234]%}"
  BASE02="%{$FG[235]%}"
  BASE01="%{$fg[darkgray]%}"
  BASE00="%{$FG[241]%}"
  BASE0="%{$FG[244]%}"
  BASE1="%{$fg[gray]%}"
  BASE2="%{$fg[white]%}" 
  BASE3="%{$FG[230]%}"
  YELLOW="%{$fg[yellow]%}"
  ORANGE="%{$FG[166]%}"
  RED="%{$fg[red]%}"
  MAGENTA="%{$fg[magenta]%}"
  VIOLET="%{$FG[61]%}"
  BLUE="%{$fg[blue]%}"
  CYAN="%{$fg[cyan]%}"
  GREEN="%{$fg[green]%}"
  BLACK="%{$fg[black]%}"
  WHITE="%{$fg[white]%}"
  CLEAR="%{$FG[0]%}"
  RESET="%{${reset_color}%}"

  # Symbols
  RIGHT_SEG_SEP=""
  LEFT_SEG_SEP=""
  PLUSMINUS="\u00b1"
  BRANCH="\ue0a0"
  DETACHED="\u27a6"
  CROSS="\u2718"
  LIGHTNING="\u26a1"
  GEAR="\u2699"
  BULLET="\u233e"
}

solar_hostname() {
  SOLAR_HOSTNAME="${${(%):-%n@%m}} "
}

solar_path() {
  SOLAR_PATH="${${(%):-%~}} "
}

function solar_rbenv() {
  SOLAR_RBENV=" $(rbenv version-name)"
  #print ${SOLAR_RBENV} 
}

function solar_git() {
  SOLAR_GIT="$(git_cwd_info_raw) "
  # print ${SOLAR_GIT}
}

solar_bat() {
  SOLAR_BAT="[48%\] ▄ "
#  SOLAR_BAT=" $(battery) "

 }


#  I need to get the size before formating is applied, there has got to be a better way
solar_padding() {
  local param
  param=$1
  while (( i++ < ${param} )) { SOLAR_PADDING+="."; }
  #print ${SOLAR_PADDING}
}



solar_main() {
  # initialize functions so we can calc term width
  local param
  
  for seg_width in solar_bat solar_git solar_path solar_rbenv solar_hostname; do
    eval $seg_width
    (( param = $param + ${#${(e)seg_width:+\$$seg_width:u}} ))
   # while (( i++ < ${param} )) { $seg_width:u_PAD+="+"; }
  done
  print $param
  solar_padding $((( ${COLUMNS} - ${param} )))
}

solar_powered_setup() {
  load_glyphs
  typeset -A hash
  autoload -U colors && colors
  autoload -Uz add-zsh-hook
  prompt_opts=(cr subst percent)
  add-zsh-hook precmd solar_powered_precmd
}

solar_powered_precmd() {
  solar_main "$@"
  PROMPT='${SOLAR_HOSTNAME_PAD}${SOLAR_HOSTNAME}${SOLAR_PATH}'
  RPROMPT='${SOLAR_GIT}${SOLAR_RBENV}${SOLAR_BAT}'
}

solar_powered_setup "$@"
