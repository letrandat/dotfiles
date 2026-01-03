#!/usr/bin/env zsh
alias ws="cd ~/workspace"
alias dc="git reset --hard"
alias st="git stash"
alias ust="git stash pop"
alias df="git diff"
alias dff="git diff --staged"
alias a="git add --all"
alias ua="git reset HEAD~"
alias ss="git status"
alias m="git checkout master"
alias b="git checkout"
alias squash="git rebase -i master"
alias lg="lazygit"
alias ld="lazydocker"

# set python to homebrew python3
# this is going to create so many problem for me, #FIXME
# alias python="/opt/homebrew/bin/python3"


# set NVIM_APPNAME to nvim-vscode
alias ncode='NVIM_APPNAME="nvim-vscode" nvim'

# Use nvim as vim if available
command -v nvim &> /dev/null && alias vim='nvim'

# set alias for tmux-sessionizer
alias tmux-sessionizer='bash ~/.local/dotfiles-bin/tmux-sessionizer'
bindkey -s ^f "tmux-sessionizer\n"

# AI Coding Tools
alias cc="claude"
alias ge="gemini"
# amp with free mode as default
alias af='amp --mode free'
