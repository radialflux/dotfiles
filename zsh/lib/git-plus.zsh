function git_branch_name() {
  GIT_BRANCH_NAME=$(command git rev-parse --abbrev-ref HEAD 2> /dev/null);
  if [[ $GIT_BRANCH_NAME != "" ]]; then
    echo $GIT_BRANCH_NAME
    return 0
  fi
}
