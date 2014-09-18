# vim:ft=zsh ts=2 sw=2 sts=2

load_glyphs () {
  # Solarized colors
  BASE03=234 
  BASE02=235 
  BASE01=240 
  BASE00=241 
  BASE0=244 
  BASE1=245 
  BASE2=254 
  BASE3=230 
  YELLOW=136 
  ORANGE=166 
  RED=160 
  MAGENTA=125 
  VIOLET=61 
  BLUE=blue 
  CYAN=37 
  GREEN=green 
  BLACK=$BASE02
  WHITE=$BASE3
  CLEAR=0

  # Symbols
  R_SEGMENT_SEPARATOR="\ue0b2"
  L_SEGMENT_SEPARATOR="\ue0b0"
  L_DEVIDER=""
  R_DEVIDER=
  PLUSMINUS="\u00b1"
  BRANCH="\ue0a0"
  DETACHED="\u27a6"
  CROSS="\u2718"
  LIGHTNING="\u26a1"
  GEAR="\u2699"
  BULLET="\u233e"
}

bottom_segment () {
  local bg fg nbg nfg side info
  bg=%K{$1} ; fg=%F{$2} ; nbg=%K{$3} ; nfg=%F{$1} ; side=$4 ; info=$5 ; dir=$6 

  if [[ ${side} == "left" && ${dir} == "bottom" ]]; then
    seg=$L_SEGMENT_SEPARATOR 
    print -n "%{$bg$fg%}"
    print -n "${info}%{%f%k%}%{reset_color%}"
    print -n "${nbg}${nfg}${seg}%{%k%f%}%{reset_color%}"
    return 0
  elif [[ ${side} == "right" && ${dir} == "bottom" ]] then
    seg=$R_SEGMENT_SEPARATOR
    print -n "%{${nbg}${nfg}%}${seg}%{%f%k%}%{reset_color%}"
    print -n "%{$bg$fg%}"
    print -n "${info:u}%f%k"
    return 0
  else
    print -n "$bg"
    print -n "${info}%k"
  fi
}


solar_powered_top_left () {
  get_path_array "$@"
  top_segment_maker ${ORANGE} "${(l:${ZSH_HOSTNAME_LEN}:: :)}"
  top_segment_maker ${BASE2} "${(l:${ZSH_PATH_LEN}:: :)}"
}

solar_powered_top_right () {
  top_segment_maker ${BASE2} ${CLEAR} " "
  top_segment_maker ${BASE0} ${BASE2} " "
}

solar_powered_bottom_left () {
  print ${ZSH_HOSTNAME} 
}

get_host () {
  ZSH_HOSTNAME=${${(%):-%n@%m}}
  ZSH_HOSTNAME_LEN=${#${(%):-%n@%m}}
}

get_path () {
  ZSH_PATH=${${(%):-%~}}   
  ZSH_PATH_LEN=${#${(%):-%~}}
}



error() {
  echo "Not enough arguments\n"
  return 1    
}

solar_powered_main () {
  get_host
  get_path
  solar_powered_bottom_left
}

solar_powered_precmd () {
  PROMPT=$'$(solar_powered_main) '
}

solar_powered_setup () {

  autoload -Uz add-zsh-hook
  prompt_opts=(cr subst percent)
  add-zsh-hook precmd solar_powered_precmd

  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' check-for-changes false
  zstyle ':vcs_info:git*' formats '%b'
  zstyle ':vcs_info:git*' actionformats '%b (%a)'
}

solar_powered_setup "$@"
