#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

print_git_branch() {
  local working_dir=$(tmux display-message -p "#{pane_current_path}")
  local branch=$(cd $working_dir && git branch)
  echo $branch
}

main() {
  print_git_branch
}
main
