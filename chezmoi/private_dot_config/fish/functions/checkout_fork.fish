function checkout_fork --description "Checkout branch of someone else's fork"
    if test (count $argv) -eq 0
        echo "Usage: checkout_fork username:branch"
        return 1
    end

    set GIT_USERNAME (echo $argv[1] | cut --delimiter=':' --fields=1)
    set BRANCH (echo $argv[1] | cut --delimiter=':' --fields=2)
    set REMOTE (git config remote.origin.url | sed -e "s|:.*/|:$GIT_USERNAME/|g")

    # Add a remote for the fork (if one with the same name doesn't already exist)
    if not git remote get-url $GIT_USERNAME > /dev/null 2>&1
        git remote add $GIT_USERNAME $REMOTE
    end

    # Fetch branches of the fork
    git fetch --tags $GIT_USERNAME

    # Checkout the fork's branch
    git checkout $GIT_USERNAME/$BRANCH

    # Create a local copy of the fork's branch
    git checkout -b $BRANCH

    # Set upstream of the branch to be able to pull changes
    git branch --set-upstream-to=$GIT_USERNAME/$BRANCH $BRANCH
end
