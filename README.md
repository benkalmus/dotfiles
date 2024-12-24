# Ben's dotfiles

## List of required software on fresh install

- kitty terminal from
  - `curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin`
- zsh and ohmyzsh
  - p10k
- brew
- tmux from brew
  - to set config location: `tmux -f ~/.tmux.conf`
- nvim from snap channel edge
- terminal file managers
  - lf `https://github.com/gokcehan/lf/releases`
  - ranger `https://github.com/ranger/ranger`

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
