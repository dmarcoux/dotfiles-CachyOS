function up --description "Go up N parent directories"
    # Defaults to 1 when no argument is provided
    set -l count 1
    if test (count $argv) -gt 0
        set count $argv[1]
    end

    for i in (seq $count)
        cd ..
    end
end
