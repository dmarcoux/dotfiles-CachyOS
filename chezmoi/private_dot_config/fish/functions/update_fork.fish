function update_fork --description "Update fork of a Git repository (setup with fork_repo)"
    # Get the default branch
    set DEFAULT_BRANCH (git remote show origin | sed -n 's| *HEAD branch: ||p')

    # Checkout the default branch or exit if it failed
    if not git checkout $DEFAULT_BRANCH
        return 1
    end

    # Rebase the default branch on the upstream changes
    git pull --rebase --autostash upstream $DEFAULT_BRANCH

    # Push updated default branch to my fork
    git push origin $DEFAULT_BRANCH

    git submodule update
end
