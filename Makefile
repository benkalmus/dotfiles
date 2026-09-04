DOTFILES := $(shell pwd)
PACKAGES := tmux zsh git wezterm kitty
DANGER_PACKAGES := system

ALL_PACKAGES := $(PACKAGES) $(DANGER_PACKAGES)

.PHONY: all stow stow-system unstow unstow-system restow adopt clean

all: stow

# User-level packages: stow to $HOME
stow:
	@for pkg in $(PACKAGES); do \
		echo "Stowing $$pkg..."; \
		stow -v -R -t $(HOME) $$pkg; \
	done

# System-level: stow to / (requires root)
stow-system:
	@echo "Creating systemd drop-in directories if missing..."
	@sudo mkdir -p /etc/systemd/system.conf.d /etc/systemd/user.conf.d /etc/systemd/logind.conf.d
	@echo "Stowing system configs to /..."
	@sudo stow -v -R -t / system
	@echo "Reloading systemd manager config..."
	@sudo systemctl daemon-reload
	@echo "Done. Re-login or run: prlimit --pid=\$$\$$ --nproc=65536"

unstow:
	@for pkg in $(PACKAGES); do \
		echo "Unstowing $$pkg..."; \
		stow -v -D -t $(HOME) $$pkg; \
	done

unstow-system:
	@echo "Removing system config symlinks..."
	@sudo stow -v -D -t / system
	@sudo rm -f /etc/systemd/system.conf.d/99-nproc.conf \
	           /etc/systemd/user.conf.d/99-nproc.conf \
	           /etc/systemd/logind.conf.d/99-nproc.conf
	@sudo systemctl daemon-reload
	@echo "System configs reverted."

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