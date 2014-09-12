# This is an opinionated theme for the formatting


function csl() {
  local fc bc fg bg ng txt
  [[ -n fg ]] && fg="%F{$1}" || fg=""
  [[ -n bg ]] && bg="%K{$2}"|| bg=""
  [[ -n ng ]] && ng="%K{$3}" || ng=""
  [[ -n txt ]] && txt=$4 || txt=$3
  sep=%F{$2}$POWERLINE_LEFT_SEGMENT_SEPARATOR 
  fc=%k; bc=%f; cc=$fc$bc

  if [[ -z $4 ]]; then
    print -n "$fg$bg$txt$cc$sep$fc"
  else
    print -n "$fg$bg$txt$cc$ng$sep$cc"
  fi

}

prompt_setup() {
  autoload -Uz add-zsh-hook
  autoload -Uz vcs_info

  prompt_opts=(cr subst percent)

  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' check-for-changes false
  zstyle ':vcs_info:git*' formats '%b'
  zstyle ':vcs_info:git*' actionformats '%b (%a)'
}


# Set USER_POWERLINE_DATE_FORMAT in .zshrc

if [ "$USER_POWERLINE_DATE_FORMAT" = "" ]; then
  POWERLINE_DATE_FORMAT=%D{%Y.%m.%d}
else
  POWERLINE_DATE_FORMAT=$USER_POWERLINE_DATE_FORMAT
fi

# Set USER_POWERLINE_PATH (like '%~' in .zshrc

if [ "$USER_POWERLINE_PATH" = "" ]; then
  POWERLINE_CURRENT_PATH="%1~"
else 
  POWERLINE_CURRENT_PATH=$USER_POWERLINE_PATH
fi
 
# Set USER_POWERLINE_NAME in .zshrc

if [ "$USER_POWERLINE_NAME" = "" ]; then
  POWERLINE_USER_NAME="%n@%M"
else 
  POWERLINE_USER_NAME=$USER_POWERLINE_NAME
fi


# Set value to any of these in .zshrc

POWERLINE_LEFT_SEGMENT_SEPARATOR=""
POWERLINE_RIGHT_SEGMENT_SEPARATOR=""


if [ "$POWERLINE_GIT_CLEAN" = "" ]; then
  POWERLINE_GIT_CLEAN="✔"
fi

if [ "$POWERLINE_GIT_DIRTY" = "" ]; then
  POWERLINE_GIT_DIRTY="✘"
fi

if [ "$POWERLINE_GIT_ADDED" = "" ]; then
  POWERLINE_GIT_ADDED="✚"
fi

if [ "$POWERLINE_GIT_MODIFIED" = "" ]; then
  POWERLINE_GIT_MODIFIED="✹"
fi

if [ "$POWERLINE_GIT_DELETED" = "" ]; then
  POWERLINE_GIT_DELETED="✖"
fi

if [ "$POWERLINE_GIT_UNTRACKED" = "" ]; then
  POWERLINE_GIT_UNTRACKED="✭"
fi

if [ "$POWERLINE_GIT_RENAMED" = "" ]; then
  POWERLINE_GIT_RENAMED="➜"
fi

if [ "$POWERLINE_GIT_UNMERGED" = "" ]; then
  POWERLINE_GIT_UNMERGED="═"
fi

if [ "$POWERLINE_GIT_PROMPT_AHEAD" = "" ]; then
  POWERLINE_GIT_PROMPT_AHEAD=" ⬆"
fi

if [ "$POWERLINE_GIT_PROMPT_BEHIND" = "" ]; then
  POWERLINE_GIT_PROMPT_BEHIND=" ⬇"
fi

if [ "$POWERLINE_GIT_PROMPT_DIVERGED" = "" ]; then
  POWERLINE_GIT_PROMPT_DIVERGED=" ⬍"
fi

if [ "$POWERLINE_GIT_PROMPT_PREFIX" = "" ]; then
  POWERLINE_GIT_PROMPT_PREFIX=" \ue0a0 "
fi

if [ "$POWERLINE_GIT_SEGMENT_SEPARATOR" = "" ]; then
  POWERLINE_GIT_SEGMENT_SEPARATOR="\ue0b0"
fi

if [ "$POWERLINE_GIT_PLUSMINUS" = "" ]; then
  POWERLINE_GIT_PLUSMINUS="\u00b1"
fi

if [ "$POWERLINE_GIT_BRANCH" = "" ]; then
  POWERLINE_GIT_BRANCH="\ue0a0"
fi

if [ "$POWERLINE_GIT_DETACHED" = "" ]; then
  POWERLINE_GIT_DETACHED="\u27a6"
fi

if [ "$POWERLINE_CROSS" = "" ]; then
  POWERLINE_CROSS="\u2718"
fi

if [ "$POWERLINE_GIT_LIGHTNING" = "" ]; then
  POWERLINE_GIT_LIGHTNING="\u26a1"
fi

if [ "$POWERLINE_GIT_GEAR" = "" ]; then
  POWERLINE_GIT_GEAR="\u2699"
fi

POWERLINE_BRANCH=$(current_branch)

if [ "$POWERLINE_BRANCH" = "" ]; then
  POWERLINE_BRANCH=" Safe "
else
    POWERLINE_BRANCH=" $(current_branch) "
fi

POWERLINE_TIME_SINCE_COMMIT=$(git_time_details)

ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=" $POWERLINE_GIT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN=" $POWERLINE_GIT_CLEAN"
ZSH_THEME_GIT_PROMPT_ADDED=" $POWERLINE_GIT_ADDED"
ZSH_THEME_GIT_PROMPT_MODIFIED=" $POWERLINE_GIT_MODIFIED"
ZSH_THEME_GIT_PROMPT_DELETED=" $POWERLINE_GIT_DELETED"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" $POWERLINE_GIT_UNTRACKED"
ZSH_THEME_GIT_PROMPT_RENAMED=" $POWERLINE_GIT_RENAMED"
ZSH_THEME_GIT_PROMPT_UNMERGED=" $POWERLINE_GIT_UNMERGED"

POWERLINE_GIT_INFO=" $(git_prompt_info) "
POWERLINE_BATTERY=" $(battery_pct_prompt) "

POWERLINE_LEFT_1="$SSH_STATUS"
POWERLINE_LEFT_2=$(csl black green blue $POWERLINE_BRANCH:u)
POWERLINE_LEFT_3=$(csl white blue white $POWERLINE_CURRENT_PATH)
POWERLINE_LEFT_4=$(csl black white $POWERLINE_BATTERY)

POWERLINE_RIGHT_1="$POWERLINE_GIT_INFO"
POWERLINE_RIGHT_2="$POWERLINE_DATE_FORMAT "
POWERLINE_RIGHT_3="$RVM_CURRENT_RUBY_VERSION:u"
POWERLINE_RIGHT_4="$POWERLINE_BATTERY"

PROMPT="$POWERLINE_LEFT_2$POWERLINE_LEFT_3$POWERLINE_LEFT_4 "
RPROMPT="$POWERLINE_RIGHT_1 $POWERLINE_RIGHT_2 $POWERLINE_RIGHT_3 $POWERLINE_RIGHT_4"

