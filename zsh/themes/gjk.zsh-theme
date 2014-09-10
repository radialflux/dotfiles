setopt prompt_subst
function collapse_pwd {
    echo $(pwd | sed -e "s,^$HOME,~,")
}

function hosttype {
case `uname` in
    Linux)
        HOSTTYPE="%{$fg[yellow]%}☇%{$reset_color%}"
        ;;
    Darwin)
        HOSTTYPE="%{$fg[red]%}%{$reset_color%}"
        ;;
esac
echo $HOSTTYPE
}
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%} ✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} ✓"
#export PS1="\n%{\e[0;32m%}\u@\h$HOSTTYPE%{\e[m%} %{\e[1;34m%}\w%{\e[m%} %{\e[1;34m%}\nλ%{\e[m%} %{\e[1;37m%}"
# export PS2='%{\e[1;33m%}➞  %{\e[1;37m%}'
#PROMPT="%{$fg[green]%}%n@%m%\($(hosttype)%{$fg[green]%})%{$fg[blue]%} $(collapse_pwd) %{$reset_color%} "
PROMPT="%{$fg[green]%}%n@%m%\($(hosttype)%{$fg[green]%})%{$fg[blue]%} %~
λ %{$reset_color%}"
RPROMPT='$(git_prompt_info)'
