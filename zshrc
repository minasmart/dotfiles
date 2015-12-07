# ~/.zshrc

# Convenience
alias be='bundle exec'
alias ls='ls -G'
alias ll='ls -l'
alias la='ls -la'

# Shell
bindkey '^R' history-incremental-pattern-search-backward
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=2000
export SAVEHIST=3000
export EDITOR=vim
export BASE16_SHELL="$HOME/code/resources/base16-shell/base16-eighties.dark.sh"
export POWERLINE_ROOT="$(brew --prefix)/lib/python2.7/site-packages/powerline"
setopt hist_ignore_all_dups
setopt autocd
setopt extendedglob
zstyle ':completion:*' menu select
fpath=(/usr/local/share/zsh-completions $fpath)
autoload -Uz compinit
compinit

[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

fpath=(/usr/local/share/zsh-completions $fpath)

# Prompt
source "${HOME}/.zprompt"

# Secrets
if [ -e "${HOME}/.secrets" ]; then
  source "${HOME}/.secrets"
fi

# Me
export PROJECT_HOME=$HOME/code
export HOMEBREW_GITHUB_API_TOKEN='6bfc3ebfc8d5f47222db9e6edd941b2258fb0082'

# Python
export PYTHONSTARTUP=$HOME/.pystartup
export WORKON_HOME=$HOME/.virtualenvs
# source /usr/local/share/python/virtualenvwrapper_lazy.sh

# Ruby
export RBENV_ROOT=$(brew --prefix)/var/rbenv
if which rbenv > /dev/null; then
  eval "$(rbenv init -)"
fi
export EXECJS_RUNTIME=Node

# Node
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# GPG
export GPG_TTY=$(tty)

# MITMProxy
alias mitmproxy='mitmproxy --palette solarized_dark'
alias mp=mitmproxy

# Highlight syntax
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
