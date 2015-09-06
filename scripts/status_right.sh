#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$CURRENT_DIR/helpers.sh"

print_status_right() {
  local working_dir=$(tmux display-message -p "#{pane_current_path}")
  local branch=$(cd "$working_dir" && git symbolic-ref --short HEAD)

  local green="#[fg=colour236,bg=colour150]"
  local green_arrow="#[fg=colour150,bg=colour237,nobold,nounderscore,noitalics]"

  local status_right="$green_arrow$green $branch"
  local interpolated=$(tmux display-message -p "$status_right")

  # "#[fg=colour249,bg=colour237] %Y-%m-%d  %I:%M #[fg=colour4,bg=colour237,nobold,nounderscore,noitalics]#[fg=colour150,bg=colour237,nobold,nounderscore,noitalics]#[fg=colour236,bg=colour150] 18 #[fg=colour236,bg=colour150] + #[fg=colour237,bg=colour150,nobold,nounderscore,noitalics]#[fg=colour131,bg=colour237,nobold,nounderscore,noitalics]#[fg=colour236,bg=colour131] 37 #[fg=colour236,bg=colour131] - #[fg=colour237,bg=colour131,nobold,nounderscore,noitalics]#[fg=colour3,bg=colour237,nobold,nounderscore,noitalics]#[fg=colour236,bg=colour3] #{git_branch}#[fg=colour3,bg=colour3] #()"

  echo $interpolated
}

main() {
  print_status_right
}

main
