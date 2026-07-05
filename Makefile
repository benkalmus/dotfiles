DOTFILES := $(shell pwd)
PACKAGES := tmux zsh git wezterm kitty

.PHONY: all stow unstow restow adopt clean

all: stow

stow:
	@for pkg in $(PACKAGES); do \
		echo "Stowing $$pkg..."; \
		stow -v -R -t $(HOME) $$pkg; \
	done

unstow:
	@for pkg in $(PACKAGES); do \
		echo "Unstowing $$pkg..."; \
		stow -v -D -t $(HOME) $$pkg; \
	done

restow: unstow stow

adopt:
	@for pkg in $(PACKAGES); do \
		echo "Adopting $$pkg..."; \
		stow -v --adopt -t $(HOME) $$pkg; \
	done

clean:
	@echo "Removing old symlinks..."
	@for pkg in $(PACKAGES); do \
		stow -v -D -t $(HOME) $$pkg 2>/dev/null; \
	done
	@rm -f $(HOME)/.zshrc $(HOME)/.tmux.conf $(HOME)/.gitconfig \
		$(HOME)/.aliases $(HOME)/.p10k.zsh $(HOME)/.wezterm.lua
	@rm -rf $(HOME)/.config/kitty $(HOME)/.config/scripts $(HOME)/.config/zsh
	@echo "Clean. Run 'make stow' to deploy."