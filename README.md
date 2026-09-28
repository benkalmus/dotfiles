# Ben's dotfiles

## List of required software on fresh install

- kitty terminal from
  - `curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin`
  - [Docs](https://sw.kovidgoyal.net/kitty/overview)
- trash-cli: `sudo apt install trash-cli`
- fish shell
  - `sudo pacman -S fish`
  - `chsh -s $(which fish)`
  - tide prompt: `fish -c "fisher install IlanCosman/tide@v6"`
  - run `tide configure` to customize prompt
- brew
  - `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
  - Apps:
  ```sh
    # for sessionx
    brew install fzf
    brew install ripgrep
    # for nvim
    brew install jesseduffield/lazygit/lazygit
    # for fzf-tmux
    sudo apt install bat
  ```
- tmux from brew `brew install tmux`
  - install tpm: `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
  - to set config location: `tmux -f ~/.tmux.conf`
  - install catpuccin theme: `git clone -b v2.1.2 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux`
- nvim from snap channel edge `sudo apt install nvim --channel=latest/edge --classic`
  - fetch repo: `git clone git@github.com:benkalmus/nvim-config.git ~/.config/nvim`
  - lazygit ``
- trash-cli `sudo apt install trash-cli -y`
- terminal file managers
  - ranger [repo](https://github.com/ranger/ranger) `sudo apt install ranger -e`
  - lf [lf](https://github.com/gokcehan/lf/releases)

## Optional

- wireguard
- asdf
  - `brew install asdf`
- ssh suspend block
  - Stowed as user service: `systemd/.config/systemd/user/ssh-inhibit.service`
  - Script: `systemd/.config/scripts/ssh-inhibit.sh`
  - Enable: `systemctl --user daemon-reload && systemctl --user enable --now ssh-inhibit.service`
  - Check: `systemd-inhibit --list`
  - Blocks `sleep:idle` only while port 22 has an active session.

## Set up

Uses [GNU Stow](https://www.gnu.org/software/stow/manual/stow.html) to manage symlinks.

```sh
# Install stow
sudo apt install stow

# Clone and deploy
git clone git@github.com:benkalmus/dotfiles.git ~/dotfiles
cd ~/dotfiles
make
```

If upgrading from old symlink-based setup:

```sh
cd ~/dotfiles
make clean && make
```

Or manually:

```sh
stow -v -R -t ~ fish tmux git wezterm kitty
```

First-time setup (adopt existing files):

```sh
stow --adopt -t ~ fish tmux git wezterm kitty
```

## Tmux resurrect recovery

State lives in `~/.local/share/tmux/resurrect/` (the `~/.tmux/resurrect` dir does not exist, so the XDG path is used). `last` is a symlink to the newest save.

If `prefix C-r` (prefix is `C-Space`) says "Tmux resurrect file not found!", `last` is a dangling symlink. This happens when two saves start in the same second: both resolve to the same filename, one symlinks `last` to it, the other sees identical content and `rm`s it (`save.sh` `files_differ` else-branch).

Repoint `last` at the newest intact save and retry:

```sh
cd ~/.local/share/tmux/resurrect
readlink -f last        # confirm it is dangling
ls -t tmux_resurrect_*.txt | head
ln -fs "$(ls -t tmux_resurrect_*.txt | head -1)" last
```

Then press `prefix C-r`. Note `pane_contents.tar.gz` is overwritten by the newer failed save, so scrollback may not match the layout timestamp exactly. Layout and processes restore correctly.
