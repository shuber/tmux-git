#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$CURRENT_DIR/helpers.sh"

print_status_left() {
  local working_dir=$(tmux display-message -p "#{pane_current_path}")
  local status_left=$(cd "$working_dir" && git log -1 --pretty=format:%h)

  echo $status_left
}

main() {
  print_status_left
}

main
