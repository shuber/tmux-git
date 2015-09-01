#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$CURRENT_DIR/helpers.sh"

print_git_shortsha() {
  local working_dir=$(tmux display-message -p "#{pane_current_path}")
  local shortsha=$(cd "$working_dir" && git log -1 --pretty=format:%h)

  echo $shortsha
}

main() {
  print_git_shortsha
}

main
