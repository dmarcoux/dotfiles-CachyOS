function fork_repo --description "Fork a Git repository, clone it, create fork on GitHub and set remotes"
    if test (count $argv) -eq 0
        echo "Usage: fork_repo git@github.com:username/repo.git"
        return 1
    end

    # Remotes:
    # upstream is the upstream repository
    # origin is the newly created fork
    set GH_TOKEN (op read 'op://Personal/github.com/CLI Access Token')
    GH_TOKEN=$GH_TOKEN gh repo fork $argv[1] --clone=true --remote=true
end
