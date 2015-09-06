#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$CURRENT_DIR/scripts/helpers.sh"

git_branch="#($CURRENT_DIR/scripts/branch.sh)"
git_branch_interpolation="\#{git_branch}"

git_sha="#($CURRENT_DIR/scripts/sha.sh)"
git_sha_interpolation="\#{git_sha}"

git_shortsha="#($CURRENT_DIR/scripts/shortsha.sh)"
git_shortsha_interpolation="\#{git_shortsha}"

git_subject="#($CURRENT_DIR/scripts/subject.sh)"
git_subject_interpolation="\#{git_subject}"

status_right="#($CURRENT_DIR/scripts/status_right.sh)"
status_right_interpolation="\#{status_right}"

interpolate_variables() {
	local string=$1
	local branch_interpolated=${string/$git_branch_interpolation/$git_branch}
	local sha_interpolated=${branch_interpolated/$git_sha_interpolation/$git_sha}
	local shortsha_interpolated=${sha_interpolated/$git_shortsha_interpolation/$git_shortsha}
	local subject_interpolated=${shortsha_interpolated/$git_subject_interpolation/$git_subject}
	local all_interpolated=${subject_interpolated/$status_right_interpolation/$status_right}

	echo $all_interpolated
}

interpolate_tmux_option() {
	local option=$1
	local value=$(get_tmux_option "$option")
	local interpolated=$(interpolate_variables "$value")

	set_tmux_option "$option" "$interpolated"
}

main() {
	interpolate_tmux_option "status-right"
	interpolate_tmux_option "status-left"
}

main
