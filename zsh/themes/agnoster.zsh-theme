# https://github.com/agnoster zsh theme

ZSH_THEME_GIT_PROMPT_DIRTY='Â±'

function _git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="âž¦ $(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"
  echo "${ref/refs\/heads\//â­  }$(parse_git_dirty)"
}

function _git_info() {
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    local BG_COLOR=green
    if [[ -n $(parse_git_dirty) ]]; then
      BG_COLOR=yellow
    fi
    echo "%{%K{$BG_COLOR}%}â®€%{%F{black}%} $(_git_prompt_info) %{%F{$BG_COLOR}%K{blue}%}â®€"
  else
    echo "%{%K{blue}%}â®€"
  fi
}

PROMPT_HOST='%{%b%F{gray}%K{black}%} %(?.%{%F{green}%}âœ”.%{%F{red}%}âœ˜)%{%F{gray}%} %m %{%F{black}%}'
PROMPT_DIR='%{%F{white}%} %1~ '
PROMPT_SU='%(!.%{%k%F{blue}%K{black}%}â®€%{%F{yellow}%} âš¡ %{%k%F{black}%}.%{%k%F{blue}%})â®€%{%f%k%b%}'


PROMPT='%{%f%b%k%}
$PROMPT_HOST$(_git_info)$PROMPT_DIR$PROMPT_SU '