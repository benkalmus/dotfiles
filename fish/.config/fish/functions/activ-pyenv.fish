function activ-pyenv
    set py_version python3
    command -q python; and set py_version python

    if test -f .venv/bin/activate.fish
        source .venv/bin/activate.fish
    else
        echo "Could not find dir .venv, Create? [y/n]"
        read -l response
        if test "$response" = y
            $py_version -m venv .venv
            source .venv/bin/activate.fish
        end
    end
end