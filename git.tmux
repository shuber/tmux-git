#!/usr/bin/env bash
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/scripts/helpers.sh"

git_branch="#($CURRENT_DIR/scripts/branch)"
git_branch_interpolation="\#{git_branch}"

do_interpolation() {
	local string=$1
	local interpolated=${string/$git_branch_interpolation/$git_branch}
	echo $interpolated
}

update_tmux_option() {
	local option=$1
	local option_value=$(get_tmux_option "$option")
	local new_option_value=$(do_interpolation "$option_value")
	set_tmux_option "$option" "$new_option_value"
}

main() {
	update_tmux_option "status-right"
	update_tmux_option "status-left"
}
main
