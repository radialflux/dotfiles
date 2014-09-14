
function return_segment() {

# bg = Background main segment
# fg = Text colors
# ng = background color of the next segment
# info = The content to be surrounded by marks

  local bg fg ng info
  bg="%K{$1}" fg="%F{$2}" info=$4
  [[ $3 = "NC" ]] && ng=%F{$2}$L_SEGMENT_SEPARATOR%f || ng="%K{$3}%F{$1}$L_SEGMENT_SEPARATOR%f%k"

  print -n "$bg$fg"
  print -n "$info%f%k"
  print -n ${ng}
}

function prompt_left_seg_a() {
  info=`print -P %m`
  return_segment $GREEN $BLACK $BASE00 " $info:u " 
}

function prompt_left_seg_b() {
  info=$(battery_status_prompt)
  return_segment $BASE00 $BLACK $BASE0 " $info " 
}

function prompt_left_seg_c() {
  info=`print -P %~`
  return_segment $BASE0 $WHITE $WHITE " $info " 
}

function prompt_left_seg_d() {
  info=$(git_branch_name)

  return_segment $WHITE $BLACK $CLEAR " $info:u "
}

#function prompt_left_seg_b() {
#  local info sep pre post 
#
#  info=" %~ "
#  sep="%K{$BASE2}%F{$BASE00}$L_SEGMENT_SEPARATOR%k"
#  pre="%K{$BASE00}%F{$BASE2}"
#  post="%k%f"
#
#  print -n ${pre} 
#  print -n ${info} 
#  print -n ${sep}
#  print -n ${post}
#}

#function prompt_left_seg_c() {
#  local info sep pre post 
#
#  [[ -z $info ]] && print -n " NOREPO ${post}" || print -n " ${info:u} ${post}"
#  sep="%K{$BASE2}%F{$BASE00}$L_SEGMENT_SEPARATOR%k"
#  post="%F{$BASE2}$L_SEGMENT_SEPARATOR"
#  pre="%K{$BASE2}%F{$WHITE}"
#
#  print -n ${pre} 
#  print -n ${info} 
#  print -n ${sep}
#  print -n ${post}
#}

function battery_status_prompt() {
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
      print -n "%F{$YELLOW}\u25e6%f";;
  esac
}
function solar_powered_main() {
  #Left side segments
   prompt_left_seg_a
   prompt_left_seg_b
   prompt_left_seg_c
   prompt_left_seg_d

}
prompt_powerline_precmd() {
  PROMPT="$(solar_powered_main) "
  POWERLINE_DATE_FORMAT=%D{%d.%m.%Y}
  POWERLINE_CURRENT_PATH="%~"
  POWERLINE_GIT_INFO=" %F{blue}%K{230}"$'\ue0b0'" %F{230}%F{black}%K{230}"$'$(git_prompt_status)%F{230}'
  RVM_CURRENT_RUBY="$(rvm_prompt_info | tr -d ')(') "
}
# Git: branch/detached head, dirty status

if [ "$POWERLINE_GIT_CLEAN" = "" ]; then
  POWERLINE_GIT_CLEAN="✔"
fi

if [ "$POWERLINE_GIT_DIRTY" = "" ]; then
  POWERLINE_GIT_DIRTY="✘"
fi

if [ "$POWERLINE_GIT_ADDED" = "" ]; then
  POWERLINE_GIT_ADDED="%F{green}✚%F{black}"
fi

if [ "$POWERLINE_GIT_MODIFIED" = "" ]; then
  POWERLINE_GIT_MODIFIED="%F{blue}✹%F{black}"
fi

if [ "$POWERLINE_GIT_DELETED" = "" ]; then
  POWERLINE_GIT_DELETED="%F{red}✖%F{black}"
fi

if [ "$POWERLINE_GIT_UNTRACKED" = "" ]; then
  POWERLINE_GIT_UNTRACKED="%F{yellow}✭%F{black}"
fi

if [ "$POWERLINE_GIT_RENAMED" = "" ]; then
  POWERLINE_GIT_RENAMED="➜"
fi

if [ "$POWERLINE_GIT_UNMERGED" = "" ]; then
  POWERLINE_GIT_UNMERGED="═"
fi

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

  # Symbols
  R_SEGMENT_SEPARATOR="\ue0b2"
  L_SEGMENT_SEPARATOR="\ue0b0"
  PLUSMINUS="\u00b1"
  BRANCH="\ue0a0"
  DETACHED="\u27a6"
  CROSS="\u2718"
  LIGHTNING="\u26a1"
  GEAR="\u2699"
  BULLET="\u233e"

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
  BLUE=33 
  CYAN=37 
  GREEN=64 
  BLACK=$BASE02
  WHITE=$BASE2
  CLEAR=0


  autoload -Uz add-zsh-hook
  prompt_opts=(cr subst percent)
  add-zsh-hook precmd prompt_powerline_precmd

}

solar_powered_setup "$@"
