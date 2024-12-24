# Ben's dotfiles

## List of required software on fresh install

- kitty terminal from
  - `curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin`
  - Docs: `https://sw.kovidgoyal.net/kitty/overview`
- zsh and ohmyzsh
  - `sudo apt install zsh`
  - `chsh -s $(which zsh)`
  - ohmyzsh `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
    - [!TODO]: instruction for installing plugins in `.zshrc`
  - p10k
- brew
  - `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
- tmux from brew
  - to set config location: `tmux -f ~/.tmux.conf`
- nvim from snap channel edge `sudo apt install nvim --channel=latest/edge --classic`
- trash-cli `sudo apt install trash-cli -y`
- terminal file managers
  - ranger `https://github.com/ranger/ranger` `sudo apt install ranger -y`
  - lf `https://github.com/gokcehan/lf/releases`

## Optional

- wireguard

## Set up

Create symlinks:

```sh
REPO_DIR=$( dirname $(pwd) )
ln -s ${REPO_DIR}/kitty.conf ~/.config/kitty/kitty.conf
ln -s ${REPO_DIR}/.tmux.conf ~/.config/.tmux.conf
ln -s ${REPO_DIR}/aliases.sh ~/.aliases
ln -s ${REPO_DIR}/.zshrc ~/.zshrc

```
