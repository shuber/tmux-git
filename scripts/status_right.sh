#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$CURRENT_DIR/helpers.sh"

print_status_right() {
  local host=$(tmux display-message -p "#h")
  local session=$(tmux display-message -p "#S")

  local green="#[fg=colour236,bg=colour150]"
  local green_arrow="#[fg=colour150,bg=colour237,nobold,nounderscore,noitalics]"

  local status_right="$green $host  $session $green_arrow"
  local interpolated=$(tmux display-message -p "$status_right")

  echo $interpolated
}

main() {
  print_status_right
}

main
