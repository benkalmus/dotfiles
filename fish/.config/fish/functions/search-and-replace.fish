function search-and-replace
    set search $argv[1]
    set replace $argv[2]
    set path "."
    set opts

    if test (count $argv) -ge 3
        set path $argv[3]
    end
    if test (count $argv) -ge 4
        set opts $argv[4..-1]
    end

    if test -d "$replace"
        set path $replace
        set replace ""
    end

    if test -z "$search"
        echo "Usage: search-and-replace <search regex> <replace> <path> [ripgrep options]

Using 1 arg performs a search
Using 2 args performs a search and replace in current directory unless second arg is a directory.
Using 2 args with second arg being a directory: a search in that directory.
Using 3 args performs a search, replace and path.
Using 3+ args, performs search and replace with path and [options] passed through to ripgrep."
        return
    end

    set logfile "replace-"(date +%Y-%m-%d-%H:%M:%S)".log"

    if test -n "$replace"
        rg -e "$search" >> "$logfile"
        rg -e "$search" "$path" -l --glob "!$logfile" $opts | xargs -r -n 1 sed -i '' "s/$search/$replace/g"
        rg -e "$replace" "$path" -C1 $opts
    else
        rg -e "$search" "$path" $opts
    end
end