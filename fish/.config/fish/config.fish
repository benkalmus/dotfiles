# CachyOS base config
source /usr/share/cachyos-fish-config/cachyos-config.fish

# Disable fastfetch on startup
function fish_greeting
end

# Disable done plugin notifications (CachyOS default)
set -g __done_min_cmd_duration 999999999

# Fix terminal rendering issues in tmux
set -g fish_escape_delay_ms 100
set -g fish_pager_show_completions 0

set -gx ASDF_DATA_DIR $HOME/.asdf
set -gx XAUTHORITY $HOME/.Xauthority
set -gx HOMEBREW_AUTO_UPDATE_SECS 86400
set -gx OPENCODE_ENABLE_EXA 1
set -gx EDITOR nvim
set -gx VISUAL nvim

# Path
fish_add_path $HOME/bin $HOME/.local/bin /usr/local/bin
fish_add_path $ASDF_DATA_DIR/shims
fish_add_path /usr/local/cuda-12/bin
set -gx LD_LIBRARY_PATH /usr/local/cuda-12/lib64 $LD_LIBRARY_PATH

# System limits
ulimit -n 100000
ulimit -u 2048

# FZF
fzf --fish | source

# Zoxide — smart directory jumper
zoxide init fish | source

# Source env file
source ~/.config/.env.fish 2>/dev/null

# Key bindings — match zsh history search behavior
bind \e\[A history-search-backward
bind \e\[B history-search-forward

# Kitty SSH fix
# if test "$TERM" = xterm-kitty
#     alias ssh="kitty +kitten ssh"
# end

# Ghostty SSH fix
if test "$TERM" = xterm-ghostty
    alias ssh="TERM=xterm-256color ssh"
end
fish_add_path /opt/rocm/bin

# WiVRn: tell Proton to use OpenXR runtime
set -gx PRESSURE_VESSEL_IMPORT_OPENXR_1_RUNTIMES 1

# Brew (must run last!)
eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
