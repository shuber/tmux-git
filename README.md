# [![Sean Huber](https://cloud.githubusercontent.com/assets/2419/6550752/832d9a64-c5ea-11e4-9717-6f9aa6e023b5.png)](https://github.com/shuber) tmux-git

Display `git` information in your `tmux` status line


## Installation

Install [tmux plugin manager](https://github.com/tmux-plugins/tpm) and add the following to the end of your `.tmux.conf`

```tmux
set -g @plugin "shuber/tmux-git"
```


## Interpolation variables

* `#{git_branch}` - display the currently checked out git branch
* `#{git_sha}` - display the sha of the latest commit
* `#{git_shortsha}` - display the short sha of the latest commit
* `#{git_subject}` - display the last commit subject (short message)
* [TODO] `#{git_additions}` - display number of uncommitted additions
* [TODO] `#{git_ahead}` - display number of commits ahead of master
* [TODO] `#{git_behind}` - display number of commits behind master
* [TODO] `#{git_deletions}` - display number of uncommitted deletions
* [TODO] `#{git_dirty}` - display number of uncommitted dirty files if any


## Usage

Add `git` interpolation variables to your `status-left` or `status-right` options in `.tmux.conf`

```tmux
set -g status-left "#{git_dirty}"
set -g status-right "#{git_ahead}/#{git_behind} | #{git_branch}"
```

Adjust the `status-interval` refresh rate if necessary

```tmux
set -g status-interval 15 # refresh status line every 15 seconds
```

Or manually refresh the status line instead

```bash
tmux refresh-client -S
```


## Contributing

* Fork the project.
* Make your feature addition or bug fix.
* Send me a pull request. Bonus points for topic branches.


## License

[MIT](https://github.com/shuber/tmux-git/blob/master/LICENSE) - Copyright © 2015 Sean Huber
