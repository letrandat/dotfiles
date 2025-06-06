alias ws="cd ~/workspace"
alias repo="cd ~/workspace/repo"
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
alias python="/opt/homebrew/bin/python3"

# set NVIM_APPNAME to nvim-kickstart
# https://github.com/nvim-lua/kickstart.nvim?tab=readme-ov-file#FAQ
alias kick='NVIM_APPNAME="nvim-kickstart" nvim'

# set NVIM_APPNAME to nvim-vscode
# https://github.com/nvim-lua/kickstart.nvim?tab=readme-ov-file#FAQ
alias nvim-vscode='NVIM_APPNAME="nvim-vscode" nvim'

# set alias for tmux-sessionizer
alias tmux-sessionizer='bash ~/.local/bin/tmux-sessionizer'

# set alias for vscode-switcher
alias vscode-switcher='bash ~/.local/bin/vscode-switcher'
bindkey -s ^f "vscode-switcher\n"
