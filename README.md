# Ben's dotfiles

## List of required software on fresh install

- kitty terminal from
  - `curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin`
  - [Docs](https://sw.kovidgoyal.net/kitty/overview)
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
  - fetch repo: `git clone git@github.com:benkalmus/nvim-config.git ~/.config/nvim`
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
ln -s ${REPO_DIR}/.tmux.conf ~/.tmux.conf
ln -s ${REPO_DIR}/.zshrc ~/.zshrc
ln -s ${REPO_DIR}/aliases.sh ~/.aliases
ln -s ${REPO_DIR}/kitty.conf ~/.config/kitty/kitty.conf

ln -s ${REPO_DIR}/scripts/ ~/.config
```

# TODOs

- Configure [stow](https://www.gnu.org/software/stow/manual/stow.html)
