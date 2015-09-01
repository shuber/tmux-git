#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$CURRENT_DIR/helpers.sh"

print_git_subject() {
  local working_dir=$(tmux display-message -p "#{pane_current_path}")
  local subject=$(cd "$working_dir" && git log -1 --pretty=format:%s)

  echo $subject
}

main() {
  print_git_subject
}

main
