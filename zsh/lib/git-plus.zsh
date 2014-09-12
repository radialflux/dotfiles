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

function current_rvm_version() {
  ref=$(command rvm current 2> /dev/null);
  [[ -n $ref ]] && CURRENT_RVM_VERSION=$ref || CURRENT_RVM_VERSION="RVM Not Installed" 
  echo $CURRENT_RVM_VERSION
}
