#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$CURRENT_DIR/helpers.sh"

print_status_right() {
  local working_dir=$(tmux display-message -p "#{pane_current_path}")
  local branch_name=$(cd "$working_dir" && git symbolic-ref --short HEAD)

  local blue="4"
  local green="10"
  local purple="5"
  local red="1"
  local yellow="3"

  local head=$(cd "$working_dir" && git rev-parse @)
  local remote=$(cd "$working_dir" && git rev-parse @{u})
  local base=$(cd "$working_dir" && git merge-base @ @{u})

  local dirty=$(cd "$working_dir" && git diff --shortstat)
  local staged=$(cd "$working_dir" && git diff --cached --stat | tail -r | grep -m 1 '.')
  local staged_files=$(echo "$staged" | perl -pe "s/^.*?(\d+) files? changed.*$/\1/")

  if [ "$dirty" ]; then # uncommitted changes
    local color=$yellow
  elif [ $head = $remote ]; then # up to date
    local color=$green
  elif [ $head = $base ]; then # need to pull
    local color=$purple
  elif [ $remote = $base ]; then # need to push
    local color=$blue
  else # diverged
    local color=$red
  fi

  local highlight="#[fg=colour236,bg=colour$color]"
  local branch="$highlight $branch_name"
  local branch_arrow="#[fg=colour$color,bg=colour237,nobold,nounderscore,noitalics]"
  local status_right="$branch"
  local spacer="#[fg=colour237,bg=colour1,nobold,nounderscore,noitalics]"

  if [ "$dirty" ]; then
    local changes=$(echo "$dirty" | perl -pe "s/^.*?(\d+) file.*$/\1/")
    local insertions=$(echo "$dirty" | perl -pe "s/^.*?(\d+) insertion.*$/\1/")
    local deletions=$(echo "$dirty" | perl -pe "s/^.*?(\d+) deletion.*$/\1/")
    status_right="$branch_arrow$highlight $changes $status_right"

    if [ "$deletions" != "$dirty" ]; then
      local deletion_status="#[fg=colour$red,bg=colour237,nobold,nounderscore,noitalics]#[fg=colour236,bg=colour$red] $deletions #[fg=colour236,bg=colour$red] - #[fg=colour237,bg=colour$red,nobold,nounderscore,noitalics]"
      status_right="$deletion_status$status_right"
    fi

    if [ "$insertions" != "$dirty" ]; then
      local insertion_status="#[fg=colour$green,bg=colour237,nobold,nounderscore,noitalics]#[fg=colour236,bg=colour$green] $insertions #[fg=colour236,bg=colour$green] + #[fg=colour237,bg=colour$green,nobold,nounderscore,noitalics]"
      status_right="$insertion_status$status_right"
    fi
  else
    status_right="$branch_arrow$status_right"
  fi

  if [ "$staged_files" -ne "0" ]; then
    local staged_files=$(echo "$staged" | perl -pe "s/^.*?(\d+) files* changed.*$/\1/")
    local number="^[0-9]+$"

    local staged_insertions=$(echo "$staged" | perl -pe "s/^.*?(\d+) insertion.*$/\1/")
    if ! [[ "$staged_insertions" =~ $number ]] ; then
      staged_insertions=0
    fi

    local staged_deletions=$(echo "$staged" | perl -pe "s/^.*?(\d+) deletion.*$/\1/")
    if ! [[ "$staged_deletions" =~ $number ]] ; then
      staged_deletions=0
    fi

    local staged_status="#[fg=colour$blue,bg=colour237,nobold,nounderscore,noitalics]#[fg=colour236,bg=colour$blue] $staged_files  $staged_insertions+  $staged_deletions- #[fg=colour237,bg=colour$blue,nobold,nounderscore,noitalics]"
    status_right="$staged_status$status_right"
  fi

  local interpolated=$(tmux display-message -p "$status_right")

  echo $interpolated
}

main() {
  print_status_right
}

main
