#!/usr/bin/env zsh
# ~/.zshrc - Zsh configuration file for Linux
# -----------------------------------------------------------------------------
# Table of Contents:
# 1. Path Configuration
# 2. Oh My Zsh Setup
# 3. History Configuration
# 4. Key Bindings
# 5. Package Managers (Homebrew, NVM)
# 6. Tools Configuration (FZF, Bat, Eza, etc.)
# 7. Navigation Tools (Zoxide)
# 8. Custom Aliases and Functions
# 9. Terminal Integration
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# 1. Path Configuration
# -----------------------------------------------------------------------------
# Set PATH to include Homebrew and user's private bin directories
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export PATH="$PATH:$HOME/.config/emacs/bin"

# -----------------------------------------------------------------------------
# 2. Oh My Zsh Setup
# -----------------------------------------------------------------------------
# Path to Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Starship prompt configuration
export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"

# Load Oh My Zsh plugins
plugins=(
  git
  web-search
  zsh-autosuggestions
  zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh

# Doom Emacs configuration directory
export DOOMDIR="$HOME/.config/doom"

# -----------------------------------------------------------------------------
# 3. History Configuration
# -----------------------------------------------------------------------------
HISTFILE=$HOME/.zhistory
HISTSIZE=1000
SAVEHIST=1000

# History options
setopt share_history        # Share history between sessions
setopt hist_expire_dups_first # Remove duplicates first when history is full
setopt hist_ignore_dups     # Don't store duplicated commands
setopt hist_verify          # Show command with history expansion before running it

# -----------------------------------------------------------------------------
# 4. Key Bindings
# -----------------------------------------------------------------------------
# History search with arrow keys
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# -----------------------------------------------------------------------------
# 5. Package Managers
# -----------------------------------------------------------------------------
# Homebrew initialization
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Node Version Manager (NVM)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # Load NVM
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # Load NVM bash completion

# -----------------------------------------------------------------------------
# 6. Tools Configuration
# -----------------------------------------------------------------------------
# FZF (Fuzzy Finder) configuration
eval "$(fzf --zsh)"

# FZF theme and default options
export FZF_DEFAULT_OPTS="
  --color=fg:#CDD6F4,bg:#1E1E2E,hl:#F5C2E7,fg+:#CDD6F4,bg+:#302D41,hl+:#F5C2E7
  --color=info:#FAB387,prompt:#F5C2E7,pointer:#F28FAD,marker:#A6E3A1,spinner:#89B4FA,header:#1E1E2E
"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# FZF functions for custom path generation and preview
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# Advanced customization of FZF options
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'" "$@" ;;
    ssh)          fzf --preview 'dig {}' "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

# Bat configuration
export BAT_THEME="Catppuccin Macchiato"

# TheFuck command correction tool
eval "$(thefuck --alias)"
eval "$(thefuck --alias fk)"

# -----------------------------------------------------------------------------
# 7. Navigation Tools
# -----------------------------------------------------------------------------
# Zoxide for better directory navigation
eval "$(zoxide init zsh)"
alias cd="z"

# -----------------------------------------------------------------------------
# 8. Custom Aliases and Functions
# -----------------------------------------------------------------------------
# Zsh configuration management
alias reload-zsh="source ~/.zshrc"
alias edit-zsh="nvim ~/.zshrc"

# File browsing and editing Aliases
alias vim="nvim"
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"

# -----------------------------------------------------------------------------
# 9. Terminal Integration
# -----------------------------------------------------------------------------
# Source ~/.profile for additional environment settings if present
[ -f "$HOME/.profile" ] && source "$HOME/.profile"

# -----------------------------------------------------------------------------
# 10. Pomodoro Work and rest timer
# -----------------------------------------------------------------------------
#🍅 Pomodoro-style timer functions

work() {
  echo "▶️  Starting 60-minute work timer..."
  timer 60m
  notify-send -i "$HOME/Pictures/tomato.png" "Pomodoro 🍅" "✅ Work timer is up! Take a break 😊"
  play -q /usr/share/sounds/freedesktop/stereo/complete.oga
}

rest() {
  echo "☕  Starting 10-minute break..."
  timer 10m
  notify-send -i "$HOME/Pictures/tomato.png" "Pomodoro 🍅" "⏰ Break is over! Get back to work 😬"
  play -q /usr/share/sounds/freedesktop/stereo/complete.oga
}

