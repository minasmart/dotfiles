# ~/.zshrc

# Convenience
alias be='bundle exec'
alias ls='ls -G'
alias ll='ls -l'
alias la='ls -la'
alias gg='git grep'
alias npm-do='env PATH=$(npm bin):$PATH'
alias eslint="npm-do eslint"

# Shell

# Key bindings
bindkey '^R' history-incremental-pattern-search-backward
bindkey -e # use emacs line editing

# History
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=2000
export SAVEHIST=3000

setopt append_history # Don't clobber. Append
setopt extended_history # Use timestamps
setopt hist_expire_dups_first # When trimming, tackle dupes first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space # Lines starting with a space are ignored
setopt hist_verify
setopt inc_append_history # Don't wait for the shell to exit before adding history
setopt share_history # share command history data

# Colours
export BASE16_SHELL="$HOME/code/resources/base16-shell/base16-eighties.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# Editor
export EDITOR=vim

# Powerline (tmux only)
export POWERLINE_ROOT="$(brew --prefix)/lib/python2.7/site-packages/powerline"

# Browse nicely
setopt autocd
setopt extendedglob

# Turns on autocompletion
fpath=(/usr/local/share/zsh-completions $fpath) # Where the completions?
autoload -Uz compinit # Load the completion module
compinit # Process completions
zstyle ':completion:*' menu select # Style of completion

# Prompt
source "${HOME}/.zprompt"

# Secrets
if [ -e "${HOME}/.secrets" ]; then
  source "${HOME}/.secrets"
fi

# Me
export PROJECT_HOME=$HOME/code

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

# Shopify specific environment set up.
if [ -f /opt/dev/dev.sh ]; then
  source /opt/dev/dev.sh
fi

export PATH="$HOME/.yarn/bin:$PATH"
