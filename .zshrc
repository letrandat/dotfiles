# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  z
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
  export VISUAL='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# ALIASES
alias zshconfig="nvim ~/.zshrc"
alias ws="cd ~/workspace"
alias repo="cd ~/workspace/repo"
alias dc="git reset --hard"
alias st="git stash"
alias ust="git stash pop"
alias df="git diff"
alias dff="git diff --staged"
alias a="git add --all"
alias ua"git reset HEAD~"
alias ss="git status"
alias m="git checkout master"
alias b="git checkout"
alias squash="git rebase -i master"
alias python="/opt/homebrew/bin/python3"
alias v="nvim"
alias lg="lazygit"
alias ld="lazydocker"

# ENVIRONMENT
export XDG_CONFIG_HOME="$HOME/.config"
# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
# java jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
# Python
export PATH="/opt/homebrew/opt/python@3.13/bin:$PATH"
# export PATH="/Library/Frameworks/Python.framework/Versions/3.13/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm use --lts

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# Added by Windsurf
export PATH="/Users/dat/.codeium/windsurf/bin:$PATH"

# Created by `pipx` on 2025-03-29 15:42:54
export PATH="$PATH:/Users/dat/.local/bin"

# starship
eval "$(starship init zsh)"


# --- VS Code Tmux Auto-Attach ---
# This block attempts to attach to a specific tmux session
# only when run inside a VS Code terminal ($TERM_PROGRAM is 'vscode')
# and not already in a tmux session.

# Check if we are in a VS Code integrated terminal
if [ "$TERM_PROGRAM" = "vscode" ]; then
    SESSION_NAME="vscode"
    # Capture the current directory of the VS Code terminal
    VSCODE_CWD="$PWD"

    # check if the target session exists
    tmux has-session -t "$SESSION_NAME" 2>/dev/null
    if [ $? -eq 0 ]; then
        # Session exists, attach to it.
        # Send the cd command to the current pane of the current window in the session.
        # Use double quotes around $VSCODE_CWD to handle spaces or special characters in the path.
        # C-m simulates pressing Enter.
        # This command is sent *before* the attach happens.
        tmux send-keys -t "$SESSION_NAME:." "cd \"$VSCODE_CWD\"" C-m
        # 'exec' replaces the current shell process with tmux.
        exec tmux attach -t "$SESSION_NAME"
    else
        # Session does not exist, create a new one and attach.
        # Use -c to set the initial directory for the new session's first window.
        # 'exec' replaces the current current process with tmux.
        exec tmux new-session -c "$VSCODE_CWD" -s "$SESSION_NAME"
    fi
fi
# --- End VS Code Tmux Auto-Attach ---
