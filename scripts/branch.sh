#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

print_git_branch() {
  local pwd=$(tmux display-message -p "#{pane_current_command}")
  echo $pwd
}

main() {
  print_git_branch
}
main
