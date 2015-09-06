#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$CURRENT_DIR/helpers.sh"

print_status_right() {
  local working_dir=$(tmux display-message -p "#{pane_current_path}")
  local branch_name=$(cd "$working_dir" && git symbolic-ref --short HEAD)

  local blue="4"
  local green="150"
  local red="1"
  local yellow="3"

  local dirty=$(cd "$working_dir" && git diff HEAD --shortstat | sed -e 's/[^0-9,]//g')
  local head=$(cd "$working_dir" && git rev-parse @)
  local remote=$(cd "$working_dir" && git rev-parse @{u})
  local base=$(cd "$working_dir" && git merge-base @ @{u})

  if [ $dirty ]; then # uncommitted changes
    local color=$yellow
  elif [ $head = $remote ]; then # up to date
    local color=$green
  elif [ $head = $base ]; then # need to pull
    local color=$blue
  elif [ $remote = $base ]; then # need to push
    local color=$yellow
  else # diverged
    local color=$red
  fi

  local branch="#[fg=colour236,bg=colour$color] $branch_name"
  local branch_arrow="#[fg=colour$color,bg=colour237,nobold,nounderscore,noitalics]"
  local status_right="$branch_arrow$branch"

  if [ $dirty ]; then
    status_right="$status_right DIRTY"
  else
    status_right="$status_right NOT DIRTY"
  fi

  local interpolated=$(tmux display-message -p "$status_right")

  # "#[fg=colour249,bg=colour237] %Y-%m-%d  %I:%M #[fg=colour4,bg=colour237,nobold,nounderscore,noitalics]#[fg=colour150,bg=colour237,nobold,nounderscore,noitalics]#[fg=colour236,bg=colour150] 18 #[fg=colour236,bg=colour150] + #[fg=colour237,bg=colour150,nobold,nounderscore,noitalics]#[fg=colour131,bg=colour237,nobold,nounderscore,noitalics]#[fg=colour236,bg=colour131] 37 #[fg=colour236,bg=colour131] - #[fg=colour237,bg=colour131,nobold,nounderscore,noitalics]#[fg=colour3,bg=colour237,nobold,nounderscore,noitalics]#[fg=colour236,bg=colour3] #{git_branch}#[fg=colour3,bg=colour3] #()"

  echo $interpolated
}

main() {
  print_status_right
}

main
