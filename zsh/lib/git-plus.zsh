function git_branch_name() {
  GIT_BRANCH_NAME=$(command git rev-parse --abbrev-ref HEAD 2> /dev/null);
  if [[ $GIT_BRANCH_NAME != "" ]]; then
    echo $GIT_BRANCH_NAME
    return 0
  fi
}


function src {
  autoload -U zrecompile
    rm -f ~/.zcompdump*
    [ -f ~/.zshrc ] && zrecompile -p ~/.zshrc
    [ -f ~/.zcompdump ] && zrecompile -p ~/.zcompdump
    [ -f ~/.zcompdump ] && zrecompile -p ~/.zcompdump
    [ -f ~/.zshrc.zwc.old ] && rm -f ~/.zshrc.zwc.old
    [ -f ~/.zcompdump.zwc.old ] && rm -f ~/.zcompdump.zwc.old
    source ~/.zshrc
}



