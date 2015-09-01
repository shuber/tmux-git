#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$CURRENT_DIR/helpers.sh"

print_git_sha() {
  local working_dir=$(tmux display-message -p "#{pane_current_path}")
  local sha=$(cd "$working_dir" && git log -1 --pretty=format:%H)

  echo $sha
}

main() {
  print_git_sha
}

main
