# Images
alias icat="kitty +kitten icat"
alias k="kitty +kitten"
alias v="nvim"

# Shell
alias reloadfish="exec fish"
alias aliases="nvim ~/.config/fish/conf.d/aliases.fish"

# Tools
alias lg="lazygit"
alias opencode="env -u TMUX opencode"
alias oc="opencode"

# Git
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

# Docker
alias d="docker"
alias dc="docker compose"
alias dci="docker images -a"
alias dps="docker ps"
alias dpsa="docker ps -a"
alias dstopped="docker ps --filter status=exited"
alias dlogs="docker logs"
alias drm="docker rm"
alias drmi="docker rmi"
alias drmif="docker rmi -f"
alias drmf="docker rm -f"
alias dockerfix="sudo chmod 666 /var/run/docker.sock"

# Python
alias py="python"

# Audio
alias pipewire-restart="systemctl --user restart pipewire pipewire-pulse"

# Mosh
alias msh="mosh --no-init --ssh='ssh -p 22'"

# Other
alias lltr="ll --sort=newest"
alias untar="tar -xvf"
alias whatsmyip="curl ifconfig.me"

# Monitor aliases
alias monitor-work="monitor-input-switch 1 hdmi; and monitor-input-switch 2 hdmi"
alias monitor-half="monitor-input-switch 1 dp; and monitor-input-switch 2 hdmi"
alias monitor-home="monitor-input-switch 1 dp; and monitor-input-switch 2 dp"