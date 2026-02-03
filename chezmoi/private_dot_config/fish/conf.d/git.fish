alias gh='GH_TOKEN=(op read "op://Personal/github.com/CLI Access Token") command gh'

# For the current branch, open the web browser to create a pull request on GitHub
abbr ghpr "gh pr create --web"

abbr g git
abbr ga "git add"
# Useful to diff untracked files, see https://stackoverflow.com/questions/24329051/what-does-git-add-intent-to-add-or-n-do-and-when-should-it-be-used
abbr gaia "git add --intent-to-add"
# List branches
abbr gbra "git branch"
# Delete a branch
abbr gbrad "git branch -D"
abbr gchp "git cherry-pick"
abbr gcko "git checkout"
# Create a new branch from current branch
abbr gckob "git checkout -b"
# Select a branch with fzf and switch to it
alias gckof='git branch | fzf | cut --characters=3- | xargs --no-run-if-empty git checkout'
abbr gclo "git clone"
# Create a git commit (it will use any git commit message template set in config)
abbr gco "git commit"
# Select a commit with fzf for which a commit fixup is going to be created with the current staged changes
alias gcof='glo | fzf --ansi --no-sort | cut --delimiter=" " --fields=1 | xargs --no-run-if-empty git commit --fixup'
# Create a git commit with message (it skips any git commit message template set in config)
abbr gcom "git commit --message"
# Create a git commit with a message and open the editor (it skips any git commit message template set in config)
abbr gcoem "git commit --edit --message"
abbr gcoma "git commit --amend"
abbr gdi "git diff --relative" # show diffs relative to the current directory
# Quickly edit changed files with `vim $(gdino)`
abbr gdino "git diff --name-only"
abbr gdis "git diff --staged"
abbr gf "git fetch --tags"
abbr gfu "git fetch --tags upstream"
# Output: abbreviated_commit_hash (%h) | commit_message (%s) | author_name (%an, in yellow) | commit_date_relative (%cr, in green)
abbr glo 'git log --pretty=format:"%h %C(bold)|%C(reset) %s %C(bold)|%C(reset) %C(yellow)%an%C(reset) %C(bold)|%C(reset) %C(green)%cr%C(reset)" --max-count=100'
# Copy a string from the output of the glo alias (a commit hash for example)
alias gloy='glo | yank'
abbr gmer "git merge"
# Select a branch with fzf and merge it in the current branch
alias gmerf='git branch | fzf | cut --characters=3- | xargs --no-run-if-empty git merge'
abbr gpu "git push"
# Force push changes, but only if it won't overwrite changes from someone else on remote
abbr gpuf "git push --force-with-lease"
abbr gpure "git pull --rebase --autostash"
abbr greb "git rebase"
abbr grebc "git rebase --continue"
# From the output of the glo alias, select with fzf the commit hash to rebase on
alias grebi='glo | fzf --ansi --no-sort | cut --delimiter=" " --fields=1 | xargs --no-run-if-empty -I % bash -c "</dev/tty git rebase --interactive %"'
abbr gref "git reflog" # then: git reset HEAD@{index}
abbr gres "git reset"
abbr grev "git revert"
abbr grst "git restore --staged"
# Select commit(s) with fzf and revert it
alias grevf='glo | fzf --ansi --no-sort --multi | cut --delimiter=" " --fields=1 | xargs --no-run-if-empty git revert'
abbr gsh "git show"
# Select a commit with fzf and show it
alias gshf='glo | fzf --ansi --no-sort --preview "echo {} | cut --delimiter=\" \" --fields=1 | xargs git show" | cut --delimiter=" " --fields=1 | xargs --no-run-if-empty git show'
abbr gst "git status"
abbr gsta "git stash"
# Select a stash with fzf and show it
alias gstaf='git stash list | fzf --no-sort | sed -n "s/^stash@{\(.*\)}.*/\1/p" | xargs --no-run-if-empty git stash show'
abbr gstal "git stash list"
abbr gsu "git submodule update"
