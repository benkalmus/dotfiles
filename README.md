# Ben's dotfiles

## List of required software on fresh install

- kitty terminal from
  - `curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin`
  - [Docs](https://sw.kovidgoyal.net/kitty/overview)
- trash-cli: `sudo apt install trash-cli`
- zsh and ohmyzsh
  - `sudo apt install zsh`
  - plugins:
    - autosuggestions: `git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`
    - syntaxhighlithing: `git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`
  - p10k: `git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"`
  - `chsh -s $(which zsh)`
  - ohmyzsh `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
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

## Set up

After above have been created.
Create symlinks:

```sh
REPO_DIR="$( dirname $(pwd) )/dotfiles"
ln -snf ${REPO_DIR}/.tmux.conf ~/.tmux.conf
ln -snf ${REPO_DIR}/.zshrc ~/.zshrc
ln -snf ${REPO_DIR}/aliases.sh ~/.aliases
ln -snf ${REPO_DIR}/kitty.conf ~/.config/kitty/kitty.conf
ln -snf ${REPO_DIR}/.p10k.zsh ~/.p10k.zsh

ln -snf ${REPO_DIR}/scripts/ ~/.config
# not needed:
# ln -s ${REPO_DIR}/.tmux.conf ~/.config/tmux/tmux.conf
```

# TODOs

- Configure [stow](https://www.gnu.org/software/stow/manual/stow.html)
