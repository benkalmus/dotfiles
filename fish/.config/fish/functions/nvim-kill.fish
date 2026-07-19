function nvim-kill
    if test -z "$argv[1]"
        echo "Usage: nvim-kill <path>"
        return 1
    end

    set target (realpath "$argv[1]" 2>/dev/null; or echo "$HOME/$argv[1]")

    set pids (lsof -c nvim 2>/dev/null | awk '/cwd/ && $NF ~ target {print $2}' target="$target")

    if test -z "$pids"
        echo "No nvim processes found in: $target"
        return 1
    end

    echo "Killing nvim processes in $target: $pids"
    echo "$pids" | xargs kill
end