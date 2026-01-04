#!/usr/bin/env zsh
# ENVIRONMENT
# home config
export XDG_CONFIG_HOME="$HOME/.config"

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# PYTHON
# export PATH="/opt/homebrew/opt/python@3.13/bin:$PATH"

# GO
export PATH=$PATH:$(go env GOPATH)/bin

# NODE
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# nvm alias default stable
nvm use lts/krypton

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"


# RUBY
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# Added by Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

# Added by Windsurf
export PATH="/Users/dat/.codeium/windsurf/bin:$PATH"

# Created by `pipx` on 2025-03-29 15:42:54
export PATH="$PATH:$HOME/.local/dotfiles-bin"
export PATH="$PATH:$HOME/.local/bin"

# JAVA
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Terminal -> tmux auto-attach (Ghostty, editors)
[ -f "$HOME/.local/dotfiles-bin/tmux-autoattach.sh" ] && source "$HOME/.local/dotfiles-bin/tmux-autoattach.sh"

# opencode
export PATH=/Users/dat/.opencode/bin:$PATH
