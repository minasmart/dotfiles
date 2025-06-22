.DEFAULT_GOAL := shorthelp
.PHONY: shorthelp help install/directories install/link install/xcode install/homebrew install/tools plugins
.PHONY: update/tools update/omz update/tools

install: ## Clean install of all the tools that we need
	@$(MAKE) clean
	@$(MAKE) install/directories
	@$(MAKE) install/link
	@$(MAKE) install/tools
	@$(MAKE) install/gpg
	@$(MAKE) install/plugins

clean: ## Clean up the linked directories in the home directory.
	@rm -rf ~/.config/git ~/.config/tmux ~/.zshrc ~/.oh-my-zsh

install/directories: ## Create directories that I expect to be there
	@echo "==== creating default directories"
	@mkdir -p ~/.config

install/link: ## Link saved dotfiles to to home directory
	@echo "==== linking config files"
	@ln -s ~/workspace/dotfiles/config/git ~/.config/git
	@ln -s ~/workspace/dotfiles/config/tmux ~/.config/tmux
	@ln -s ~/workspace/dotfiles/config/nvim ~/.config/nvim
	@ln -sf ~/workspace/dotfiles/config/zshrc ~/.zshrc
	@ln -sf ~/workspace/dotfiles/config/ssh/config ~/.ssh/config

install/gpg:
	@gpg --default-new-key-algo rsa4096 --gen-key
	@gpg --armor --export $(gpg --list-keys --with-colons --with-fingerprint | awk -F: '/^fpr:/ { print $10 }' | tail -n 1) | pbcopy
	@read -p "New gpg key is in clipboard add it to github and press enter to continue ..."

install/tools: install/xcode install/homebrew install/zsh install/vim install/plug

install/xcode: ## ensure xcode doesnt get in our way
	@echo "==== ensuring xcode is setup"
	@xcode-select --install || echo "already installed"

install/homebrew: ## install my package manager
	@echo "==== installing homebrew"
	@/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	@brew install tmux macvim git gnupg ag fzf

install/omz: ## install oh my zsh sugar
	@echo "==== installing up to date zsh"
	@brew install macvim

update/tools: ## Update the tools I use every day
	@brew update
	@brew upgrade go tmux nvim git gnupg ag

update/omz: ## Update zsh plugins
	@echo "==== updating ohmyzsh"
	@omz update

install/plugins: plugins/tmux plugins/omz ## install all plugins
update/plugins: install/plugins ## update all plugins


update: | plugins update/omz update/tools ## Update tools and plugins




plugins/tmux: ## Install tmux plugins because I cant figure out tpm
	@echo "==== installing tmux plugins"
	@export REPO=tmux-plugins/tpm DEST=config/tmux/plugins/tpm; $(MAKE) plugins/install;
	@export REPO=tmux-plugins/tmux-yank DEST=config/tmux/plugins/tmux-yank; $(MAKE) plugins/install;
	@export REPO=tmux-plugins/tmux-sensible DEST=config/tmux/plugins/tmux-sensible; $(MAKE) plugins/install;

plugins/omz: ## Install themes for omz
	@export REPO=dracula/zsh DEST=~/.oh-my-zsh/custom/themes/dracula; $(MAKE) plugins/install

plugins/install: # a generic task that will clone a git plugin to a destination, requires a DEST and REPO env var
	@echo "installing ${REPO}" && \
		rm -rf ${DEST} && \
		git clone --quiet --depth=1 git@github.com:${REPO}.git ${DEST} && \
		rm -rf ${DEST}/.git && \
		echo "installed ${REPO} successfully"

shorthelp:
	@grep -E '^[a-zA-Z_0-9-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

help: ## Help output of all targets that are documented
	@grep -E '^[/a-zA-Z_0-9-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
