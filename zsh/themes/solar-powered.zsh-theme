
# Solarize colors
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

# Git Symbols
  POWERLINE_GIT_DIRTY="\u25d1"
  POWERLINE_GIT_CLEAN="\u25ce"
  POWERLINE_GIT_ADDED="%F{green}✚%F{black}"
  POWERLINE_GIT_MODIFIED="%F{blue}✹%F{black}"
  POWERLINE_GIT_DELETED="%F{red}✖%F{black}"
  POWERLINE_GIT_UNTRACKED="%F{yellow}✭%F{black}"
  POWERLINE_GIT_RENAMED="➜"
  POWERLINE_GIT_UNMERGED="═"

# Misc 
  LEFT="left"
  RIGHT="right"


function segment_maker() {

# bg = Background main segment
# fg = Text colors
# ng = background color of the next segment
# info = The content to be surrounded by marks
# side = Left or Right

  local bg=%K{$1} ; fg=%F{$2} ; nbg=%K{$3} ; nfg=%F{$1} ; side=$4 ; info=$5
  if [[ ${side} == "left" ]]; then
    seg=$L_SEGMENT_SEPARATOR 
    print -n "$bg$fg"
    print -n "${info}%f%k"
    print -n "${nbg}${nfg}${seg}%k%f"
  else
    seg=$R_SEGMENT_SEPARATOR
    print -n "${nbg}${nfg}${seg}%f%k"
    print -n "$bg$fg"
    print -n "${info:u}%f%k"
  fi
}

funtion rvm_status() {
  [[ ${RVM_CURRENT_RUBY} =~ [*ruby*] ]] && echo ${RVM_CURRENT_RUBY} || echo "SYSTEM RUBY"
}

function git_segment() {
  local info repo_status 
  info=$(current_branch) 
  repo_status=$(git_prompt_status)

  [[ -n ${info} ]] && info="${BRANCH} ${info:u}"
  

  print -n "${info}${repo_status}"

}

function battery_stat() {
  local info
  info=`battery_pct_prompt | cut -d% -f3 | tr -d '}['`
  case ${info} in
    <1-33>)
      print -n "%F{$RED}\u25e6%f";;
    <33-66>)
      print -n "%F{$ORANGE}\u25e6%f";;
    *∞*)
      print -n "%F{$WHITE}∞%f";;
    *)
      print -n "%F{$GREEN}\u25e6%f";;
  esac
}

function solar_powered_main() {
  #Left side segments
  if [[ $(current_branch) == "master" ]]; then
    segment_maker ${BLUE} ${WHITE} ${BASE00} ${LEFT} " $(git_segment) "
    segment_maker ${BASE00} ${WHITE} ${BASE1} ${LEFT} " $(battery_stat) "
    segment_maker ${BASE1} ${BLACK} ${BASE2} ${LEFT} " %m "\n
    segment_maker ${BASE2} ${BLACK} ${CLEAR} ${LEFT} " %~ "
  else
    segment_maker ${BASE00} ${WHITE} ${BASE1} ${LEFT} " $(battery_stat) "
    segment_maker ${BASE1} ${WHITE} ${BASE2} ${LEFT} " %m "
    segment_maker ${BASE2} ${BLACK} ${CLEAR} ${LEFT} " %~ "
  fi
}

function solar_powered_main_right() {
  segment_maker ${BASE2} ${BASE01} ${CLEAR} ${RIGHT} " %D{%H:%M:%S} "
  segment_maker ${BASE0} ${WHITE} ${BASE2} ${RIGHT} " $(rvm_status) "
  
}

prompt_powerline_precmd() {
  PROMPT="$(solar_powered_main) "
  RPROMPT="$(solar_powered_main_right)"
  POWERLINE_GIT_INFO=" %F{blue}%K{230}"$'\ue0b0'" %F{230}%F{black}%K{230}"$'$(git_prompt_status)%F{230}'
  RVM_CURRENT_RUBY="$(rvm_prompt_info | tr -d ')(') "
}
# Git: branch/detached head, dirty status


  ZSH_THEME_GIT_PROMPT_PREFIX="1"
  ZSH_THEME_GIT_PROMPT_SUFFIX=""
  ZSH_THEME_GIT_PROMPT_DIRTY=" $POWERLINE_GIT_DIRTY"
  ZSH_THEME_GIT_PROMPT_CLEAN=" $POWERLINE_GIT_CLEAN"

  ZSH_THEME_GIT_PROMPT_ADDED=" $POWERLINE_GIT_ADDED"
  ZSH_THEME_GIT_PROMPT_MODIFIED=" $POWERLINE_GIT_MODIFIED"
  ZSH_THEME_GIT_PROMPT_DELETED=" $POWERLINE_GIT_DELETED"
  ZSH_THEME_GIT_PROMPT_UNTRACKED=" $POWERLINE_GIT_UNTRACKED"
  ZSH_THEME_GIT_PROMPT_RENAMED=" $POWERLINE_GIT_RENAMED"
  ZSH_THEME_GIT_PROMPT_UNMERGED=" $POWERLINE_GIT_UNMERGED"
  ZSH_THEME_GIT_PROMPT_AHEAD=" ⬆"
  ZSH_THEME_GIT_PROMPT_BEHIND=" ⬇"
  ZSH_THEME_GIT_PROMPT_DIVERGED=" ⬍"


solar_powered_setup() {

  

  autoload -Uz add-zsh-hook
  prompt_opts=(cr subst percent)
  add-zsh-hook precmd prompt_powerline_precmd

  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' check-for-changes false
  zstyle ':vcs_info:git*' formats '%b'
  zstyle ':vcs_info:git*' actionformats '%b (%a)'

  precmd () {
    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
        zstyle ':vcs_info:*' formats ' [%F{green}%b%c%u%F{blue}]'
    } else {
        zstyle ':vcs_info:*' formats ' [%F{green}%b%c%u%F{red}●%F{blue}]'
    }
 
}
 
}

solar_powered_setup "$@"
