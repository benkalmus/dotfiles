# show an image in terminal
alias icat="kitty +kitten icat"
alias k="kitty +kitten"
alias v="nvim"


## ==================================================================
## old bash aliases
## ==================================================================
alias reloadzsh="source ~/.zshrc"
alias aliases="nvim ~/.aliases.zsh"

# git
alias gs="git status"
alias gp="git push"
alias gcm="git commit -m"
alias gpf="git push -f"
alias gco="git checkout"
alias gcb="git checkout -b"
alias grc="git rebase --continue"
alias gra="git rebase --abort"
alias gfa="git fetch --all"
alias gpl="git pull"
alias gca="git commit --amend"
alias gcaa="git commit --amend --no-edit"
alias ga="git add"
alias gaa="git add --update"
alias gr="git restore"
alias grs="git restore --staged"

# docker
alias d="docker"
alias dc="docker compose"
alias dci="docker images -a"
alias dps="docker ps -a"

## ==================================================================
## python
# activate python virtual environment in current directory, or asks to create one if doesnt already exist
function activ-pyenv() {
    if [[ -f ".venv/bin/activate" ]]; then
        source .venv/bin/activate
    else
        echo "Could not find dir .venv, Create? [y/n]"
        read -r CREATE
        if [[ $CREATE == "y" ]]; then
            python3 -m venv .venv
            source .venv/bin/activate
        fi
    fi
}

alias py="python3"

# linux audio
alias pipewire-restart="systemctl --user restart pipewire pipewire-pulse"

# mosh
alias msh='mosh --no-init --ssh="ssh -p 22"'

## ==================================================================
# linux commands aliases
alias rm="trash-put"
# exa replacement for ls
# alias ls="exa"
alias lltr="ll --sort=newest"
alias untar="tar -xvf"

alias whatsmyip="curl ifcfg.me"
