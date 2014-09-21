
load_glyphs() {
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
  BLUE=33 
  CYAN=37 
  GREEN=170 
  BLACK=235
  WHITE=254
  CLEAR=0

  # Symbols
  RIGHT_SEG_SEP=" "
  LEFT_SEG_SEP=" "
  L_DIVIDER=""
  R_DIVIDER=""
  PLUSMINUS="\u00b1"
  BRANCH="\ue0a0"
  DETACHED="\u27a6"
  CROSS="\u2718"
  LIGHTNING="\u26a1"
  GEAR="\u2699"
  BULLET="\u233e"

  # Misc variables
  LEFT="LEFT"
  RIGHT="RIGHT"
  TOP="TOP"
  BOTTOM="BOTTOM"
}

solar_hostname() {
  SOLAR_HOSTNAME=${${(%):-%n@%m}}
  SOLAR_HOSTNAME_LEN="$(( ${#SOLAR_HOSTNAME} + 1 )) "
}

solar_path() {
  SOLAR_PATH=${${(%):-%~}}   
  SOLAR_PATH_LEN=" $(( ${#SOLAR_PATH} + 3 ))  "
}

solar_rbenv() {
  SOLAR_RBENV=" $(rbenv version-name) "
  SOLAR_RBENV_LEN=" $(( ${#SOLAR_RBENV} + 2 )) "
}

solar_git() {
  SOLAR_GIT=" git data "
  SOLAR_GIT_LEN=" $(( ${#SOLAR_GIT} + 2 )) "
}

solar_bat() {
  local param
  param=$(battery_pct_prompt | cut -d% -f3 | tr -d '}[%')

  case ${param} in
    <1-20>)
      SOLAR_BAT="\u25cb"
      ;;
    <21-40>)
      SOLAR_BAT="\u25d4"
      ;;
    <41-60>)
     SOLAR_BAT="\u25d1"
     ;;
    <61-80>)
     SOLAR_BAT="\u25d5"
     ;;
       *∞*)
     SOLAR_BAT="\u2622"
     ;;
    *)
     SOLAR_BAT="\u25cf"
     ;;
  esac
  SOLAR_BAT_LEN=3
}

build_segment() {
  local bg=$1 fg=$2 nbg=$3 nfg=$1 info=$4 side=$5
  
  if [[ ${side} == ${LEFT} ]]; then
    print -nP ${info}
    print -nP \$${side}_SEG_SEP
  elif [[ ${side} == ${RIGHT} ]]; then
    print -nP \$${side}_SEG_SEP
    print -nP ${info}
  else
    padding=$4
    print -nP "%{%K{${bg}}%}"
    print -nP "${(l:(${padding})::.:)}%{%k%{${color_reset}%}%}"
  fi
}

solar_powered_main() {
  solar_path
  solar_hostname
  solar_bat
  solar_git
  solar_rbenv

  TERM_WIDTH=$(( ${COLUMNS} - ( ${SOLAR_BAT_LEN} + ${SOLAR_HOSTNAME_LEN} + ${SOLAR_PATH_LEN} + ${SOLAR_GIT_LEN} + ${SOLAR_RBENV_LEN} )))

  SOLAR_PROMPT_HOSTNAME=$(build_segment ${BLUE} ${WHITE} ${BASE0} "${SOLAR_HOSTNAME:l}" ${LEFT})
  SOLAR_PROMPT_PATH=$(build_segment ${GREEN} ${WHITE} ${BASE0} " ${SOLAR_PATH}" ${LEFT})
  SOLAR_PROMPT_BAT=$(build_segment ${BLUE} ${WHITE} ${BASE0} "${SOLAR_BAT}" ${RIGHT})
  SOLAR_PROMPT_GIT=$(build_segment ${ORANGE} ${WHITE} ${BASE0} "${SOLAR_GIT}" ${RIGHT})
  SOLAR_PROMPT_RBENV=$(build_segment ${BLUE} ${WHITE} ${BASE0} "${SOLAR_RBENV}" ${RIGHT})
  SOLAR_PROMPT_HOSTNAME_PAD=$(build_segment ${BLUE} ${WHITE} ${BASE0} ${SOLAR_HOSTNAME_LEN})
  SOLAR_PROMPT_GIT_PAD=$(build_segment ${BASE0} ${WHITE} ${BASE0} ${SOLAR_GIT_LEN})
  SOLAR_PROMPT_PATH_PAD=$(build_segment ${BASE0} ${BLACK} ${BASE0} ${SOLAR_PATH_LEN})
  SOLAR_PROMPT_BAT_PAD=$(build_segment ${BASE01} ${WHITE} ${BASE0} ${SOLAR_BAT_LEN})
  SOLAR_PROMPT_RBENV_PAD=$(build_segment ${BLUE} ${WHITE} ${BASE0} ${SOLAR_RBENV_LEN})
  SOLAR_PROMPT_TERMINAL_PAD=$(build_segment ${CLEAR} ${WHITE} ${BASE0} ${TERM_WIDTH})

  # Gather widths

} 

solar_powered_precmd() {
  solar_powered_main
  PROMPT=$'${SOLAR_PROMPT_HOSTNAME_PAD}${SOLAR_PROMPT_PATH_PAD}${SOLAR_PROMPT_TERMINAL_PAD}${SOLAR_PROMPT_GIT_PAD}${SOLAR_PROMPT_RBENV_PAD}${SOLAR_PROMPT_BAT_PAD}\n${SOLAR_PROMPT_HOSTNAME}${SOLAR_PROMPT_PATH} '

  RPROMPT=$'${SOLAR_PROMPT_GIT}${SOLAR_PROMPT_RBENV}${SOLAR_PROMPT_BAT}'
}

solar_powered_setup() {
  load_glyphs
  autoload -Uz add-zsh-hook
  prompt_opts=(cr subst percent)
  add-zsh-hook precmd solar_powered_precmd
}

solar_powered_setup
