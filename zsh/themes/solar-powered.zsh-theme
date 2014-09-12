

SEGMENT_SEPARATOR="\ue0b0"
PLUSMINUS="\u00b1"
BRANCH="\ue0a0"
DETACHED="\u27a6"
CROSS="\u2718"
LIGHTNING="\u26a1"
GEAR="\u2699"
BULLET="\u233e"

function battery_status_prompt() {

  case $(battery_pct_prompt) in
    <1-33>) 
      print -n " %K{orange}%F{160}\u25e6%f%k";;
    <33-66>) 
      print -n " %K{orange}%F{82}\u25e6%f%k";; 
    *∞*)
      print -n "%F{242}%K{240}"$'\ue0b2'"%K{242}%F{154} ∞ ";;
    *) 
      print -n "%K{orange}%F{154}\u25e6%f%k";;
  esac
}

# Git: branch/detached head, dirty status
prompt_git() {
  local color ref
  is_dirty() {
    test -n "$(git status --porcelain --ignore-submodules)"
  }
  ref="$vcs_info_msg_0_"
  if [[ -n "$ref" ]]; then
    if is_dirty; then
      color=yellow
      ref="${ref} $PLUSMINUS"
    else
      color=green
      ref="${ref} "
    fi
    if [[ "${ref/.../}" == "$ref" ]]; then
      ref="$BRANCH $ref"
    else
      ref="$DETACHED ${ref/.../}"
    fi
    prompt_segment $color $PRIMARY_FG
    print -Pn " $ref"
  fi
}


function git_time_details() {
  # only proceed if there is actually a git repository
  if `git rev-parse --git-dir > /dev/null 2>&1`; then
    # only proceed if there is actually a commit
    if [[ $(git log 2>&1 > /dev/null | grep -c "^fatal: bad default revision") == 0 ]]; then
      # get the last commit hash
      # lc_hash=`git log --pretty=format:'%h' -1 2> /dev/null`
      # get the last commit time
      lc_time=`git log --pretty=format:'%at' -1 2> /dev/null`

      now=`date +%s`
      seconds_since_last_commit=$((now-lc_time))
      lc_time_since=`time_since_commit $seconds_since_last_commit`

      echo "$lc_time_since"
    else
      echo ""
    fi
  else
    echo ""
  fi
}

# returns the time by given seconds
function time_since_commit() {
  seconds_since_last_commit=$(($1 + 0))

  # totals
  MINUTES=$((seconds_since_last_commit / 60))
  HOURS=$((seconds_since_last_commit/3600))

  # sub-hours and sub-minutes
  DAYS=$((seconds_since_last_commit / 86400))
  SUB_HOURS=$((HOURS % 24))
  SUB_MINUTES=$((MINUTES % 60))

  if [ "$HOURS" -gt 24 ]; then
    echo "${DAYS}d${SUB_HOURS}h${SUB_MINUTES}m"
  elif [ "$MINUTES" -gt 60 ]; then
    echo "${HOURS}h${SUB_MINUTES}m"
  else
    echo "${MINUTES}m"
  fi
}

prompt_powerline_precmd() {
  POWERLINE_DATE_FORMAT=%D{%d.%m.%Y}
  POWERLINE_CURRENT_PATH="%~"
  POWERLINE_GIT_INFO=" %F{blue}%K{white}"$'\ue0b0'" %F{white}%F{black}%K{white}"$'$(git_branch_name)$(git_prompt_status)%F{white}'
  RVM_CURRENT_RUBY="$(rvm_prompt_info | tr -d ')(') "
  POWERLINE_USER_NAME="%n@%M"
  POWERLINE_BATTERY="$(battery_status_prompt)"
  }



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

# ZSH_THEME_GIT_PROMPT_PREFIX=" \ue0a0 "
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

if [ $(id -u) -eq 1 ]; then
    POWERLINE_SEC1_BG=%K{red}
    POWERLINE_SEC1_FG=%F{red}
else
    POWERLINE_SEC1_BG=%K{green}
    POWERLINE_SEC1_FG=%F{green}
fi
POWERLINE_SEC1_TXT=%F{black}
if [ "$POWERLINE_DETECT_SSH" != "" ]; then
  if [ -n "$SSH_CLIENT" ]; then
    POWERLINE_SEC1_BG=%K{red}
    POWERLINE_SEC1_FG=%F{red}
    POWERLINE_SEC1_TXT=%F{white}
  fi
fi


solar_powered_prompt_setup() {
  autoload -Uz add-zsh-hook
  autoload -Uz vcs_info

  prompt_opts=(cr subst percent)
  add-zsh-hook precmd prompt_powerline_precmd

  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' check-for-changes false
  zstyle ':vcs_info:git*' formats '%b'
  zstyle ':vcs_info:git*' actionformats '%b (%a)'


  PROMPT="$POWERLINE_SEC1_BG$POWERLINE_SEC1_TXT ${POWERLINE_USER_NAME:l} \
%k%f$POWERLINE_SEC1_FG%K{blue}"$'\ue0b0'"%k%f%F{white}%K{blue}\
 ${POWERLINE_CURRENT_PATH}%F{blue}${POWERLINE_GIT_INFO} %k"$'\ue0b0'"%f "

  RPROMPT="%F{white}"$'\ue0b2'"%k%F{black}%K{white} ${POWERLINE_DATE_FORMAT}%f%F{240} "$'\ue0b2'"%f%k%K{240}%F{255} ${RVM_CURRENT_RUBY:u} %f%k${POWERLINE_BATTERY}"

}


solar_powered_prompt_setup "$@"
