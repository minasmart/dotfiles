.DEFAULT_GOAL := shorthelp
.PHONY: shorthelp help
.PHONY: install/directories install/link install/tools install/xcode install/homebrew install/vim-plug
.PHONY: setup/zsh setup/vim setup/gpg setup/shell-colours
.PHONY: update/tools update/vim-plugins update/all

shorthelp:
	@grep -E '^[a-zA-Z_0-9-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

help: ## Help output of all targets that are documented
	@grep -E '^[/a-zA-Z_0-9-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install: ## Clean install of all the tools that we need
	@$(MAKE) clean
	@$(MAKE) install/directories
	@$(MAKE) install/link
	@$(MAKE) install/tools
	@$(MAKE) setup/shell-colours
	@$(MAKE) setup/zsh
	@$(MAKE) setup/vim
	@$(MAKE) setup/gpg

clean: ## Clean up the linked directories in the home directory.
	@rm -rf ~/.config/{git,tmux,zellij} ~/.zshrc ~/.vimrc ~/.gnupg/gpg-agent.conf

install/directories: ## Create directories that I expect to be there
	@echo "==== creating default directories"
	mkdir -p ~/.config ~/.vim/{backup,undo,swap} ~/.gnupg

install/link: ## Link saved dotfiles to to home directory
	@echo "==== linking config files"
	ln -s ~/.dotfiles/config/git ~/.config/git
	ln -s ~/.dotfiles/config/tmux ~/.config/tmux
	ln -s ~/.dotfiles/config/zellij ~/.config/zellij
	ln -s ~/.dotfiles/config/vimrc ~/.vimrc
	ln -sf ~/.dotfiles/config/zshrc ~/.zshrc
	ln -sf ~/.dotfiles/config/zprofile ~/.zprofile
	ln -sf ~/.dotfiles/config/zshenv ~/.zshenv
	ln -sf ~/.dotfiles/config/zprompt ~/.zprompt
	ln -sf ~/.dotfiles/config/ssh/config ~/.ssh/config
	ln -sf ~/.dotfiles/config/gnupg/gpg-agent.conf ~/.gnupg/gpg-agent.conf
	ln -sf ~/.dotfiles/Brewfile ~/.Brewfile

install/tools: install/xcode install/homebrew install/vim-plug

install/xcode: ## ensure xcode doesnt get in our way
	@echo "==== ensuring xcode is setup"
	@xcode-select --install || echo "already installed"

install/homebrew: ## install my package manager
	@echo "==== installing homebrew"
	@echo "==== energizing sudo"
	@sudo true
	NONINTERACTIVE=1 curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash
	@echo "==== installing brew bundle"
	/opt/homebrew/bin/brew shellenv | eval
	/opt/homebrew/bin/brew bundle --global

install/vim-plug: ## Install plugin manager for vim
	@echo "==== install vim-plug"
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

setup/zsh: ## add brew zsh to /etc/shells and set shell to brew zsh
	@echo "==== adding Brew zsh to /etc/shells. You will be prompted for a password."
	echo /opt/homebrew/bin/zsh | sudo tee -a /etc/shells
	chsh -s /opt/homebrew/bin/zsh ${USER}

setup/shell-colours: ## grab Chris Kempson's colour set and store it in ./config
	@echo "====  checking if ~/.config/base16-shell exists"
	@if [ ! -d ~/.config/base16-shell ]; then \
		echo "~/.config/base16-shell is absent. Fetching..."; \
		git clone git@github.com:chriskempson/base16-shell.git ~/.config/base16-shell; \
	else \
		echo "~/.config/base16-shell already exists. Moving on."; \
	fi

setup/vim: ## install vim plugins
	vim +PlugInstall +qall

setup/gpg:
	chown -R ${USER} ~/.gnupg/
	chmod 600 ~/.gnupg/*
	chmod 700 ~/.gnupg
	gpg-connect-agent reloadagent /bye
	gpg --default-new-key-algo rsa4096 --gen-key
	gpg --armor --export $(gpg --list-keys --with-colons --with-fingerprint | awk -F: '/^fpr:/ { print $10 }' | tail -n 1) | pbcopy
	read -p "New gpg key is in clipboard add it to github and press enter to continue ..."

update/tools: ## Update the tools I use every day
	brew bundle --global

update/vim-plugins: ## Update the tools I use every day
	vim +PlugUpgrade +PlugUpdate +qall

update/all: install/plugins ## update all plugins

update: | update/tools update/vim-plugin ## Update tools and plugins
