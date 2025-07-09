#!/usr/bin/env zsh
# ~/.zshrc - Zsh configuration file for Linux

# -----------------------------------------------------------------------------
# 1. Environment Variables
# -----------------------------------------------------------------------------

# Set the default editor to Neovim.
export EDITOR='nvim'

# Set the directory for Doom Emacs configuration.
export DOOMDIR="$HOME/.config/doom"

# Set the location of the Zsh history file.
export HISTFILE="$HOME/.zhistory"

# Set the path to the Starship configuration file.
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

# Set the Node Version Manager (NVM) directory.
export NVM_DIR="$HOME/.nvm"

# Set Android and Java development environment variables.
export ANDROID_HOME="$HOME/Android"
export JAVA_HOME="/usr/lib/jvm/java-24-openjdk"

# -----------------------------------------------------------------------------
# 2. PATH Configuration
# -----------------------------------------------------------------------------

# The PATH variable determines where the shell looks for executable files.
# We add custom directories to the beginning of the PATH to give them priority.
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.config/emacs/bin:$PATH"
export PATH="$JAVA_HOME/bin:$PATH"
export PATH="$ANDROID_HOME/emulator:$PATH"
export PATH="$ANDROID_HOME/platform-tools:$PATH"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
export PATH="$HOME/flutter/bin:$PATH"

# -----------------------------------------------------------------------------
# 3. Oh My Zsh Setup
# -----------------------------------------------------------------------------

# Set the path to the Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Load Starship, a custom prompt for Zsh.
eval "$(starship init zsh)"

# Define the Oh My Zsh plugins to load.
plugins=(
  git
  web-search
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Load Oh My Zsh.
source "$ZSH/oh-my-zsh.sh"

# -----------------------------------------------------------------------------
# 4. History Configuration
# -----------------------------------------------------------------------------

# Set the maximum number of history entries to keep in memory and on disk.
HISTSIZE=1000
SAVEHIST=1000

# Configure Zsh history behavior.
setopt share_history          # Share history between all shell sessions.
setopt hist_expire_dups_first # Expire duplicate entries first.
setopt hist_ignore_dups       # Don't record duplicate entries.
setopt hist_verify            # Show the command before executing from history.

# -----------------------------------------------------------------------------
# 5. Key Bindings
# -----------------------------------------------------------------------------

# Bind arrow keys to search through history based on what's already typed.
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# -----------------------------------------------------------------------------
# 6. Package Manager Setup
# -----------------------------------------------------------------------------

# Load Node Version Manager (NVM) if it's installed.
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# -----------------------------------------------------------------------------
# 7. Tools Configuration
# -----------------------------------------------------------------------------

# Initialize fzf, a command-line fuzzy finder.
eval "$(fzf --zsh)"

# Configure fzf default options for a custom look and feel.
export FZF_DEFAULT_OPTS="
  --color=fg:#CDD6F4,bg:#1E1E2E,hl:#F5C2E7,fg+:#CDD6F4,bg+:#302D41,hl+:#F5C2E7
  --color=info:#FAB387,prompt:#F5C2E7,pointer:#F28FAD,marker:#A6E3A1,spinner:#89B4FA,header:#1E1E2E
"

# Configure fzf to use 'fd' for finding files, excluding the .git directory.
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"

# Configure fzf for changing directories.
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Custom fzf path completion.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Custom fzf directory completion.
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# Custom fzf command runner with previews.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'" "$@" ;;
    ssh)          fzf --preview 'dig {}' "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

# Set the theme for 'bat', a cat clone with syntax highlighting.
export BAT_THEME="Catppuccin Macchiato"

# Initialize 'thefuck', a tool that corrects typos in previous commands.
eval "$(thefuck --alias)"
eval "$(thefuck --alias fk)"

# -----------------------------------------------------------------------------
# 8. Navigation and Aliases
# -----------------------------------------------------------------------------

# Initialize zoxide, a smarter 'cd' command.
eval "$(zoxide init zsh)"

# Replace 'cd' with 'z' to use zoxide.
alias cd="z"

# Custom aliases for common commands.
alias reload-zsh="source ~/.zshrc"
alias edit-zsh="nvim ~/.zshrc"
alias vim="nvim"
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"

# -----------------------------------------------------------------------------
# 9. Terminal Integration
# -----------------------------------------------------------------------------

# Source the .profile file if it exists, for compatibility.
[ -f "$HOME/.profile" ] && source "$HOME/.profile"

# -----------------------------------------------------------------------------
# 10. Pomodoro Timer Functions
# -----------------------------------------------------------------------------

# Starts a 60-minute work timer with desktop notifications.
work() {
  echo "▶️  Starting 60-minute work timer..."
  timer 60m
  notify-send -i "$HOME/Pictures/tomato.png" "Pomodoro 🍅" "✅ Work timer is up! Take a break 😊"
  paplay /usr/share/sounds/freedesktop/stereo/complete.oga
}

# Starts a 10-minute break timer with desktop notifications.
rest() {
  echo "☕  Starting 10-minute break..."
  timer 10m
  notify-send -i "$HOME/Pictures/tomato.png" "Pomodoro 🍅" "⏰ Break is over! Get back to work 😬"
  paplay /usr/share/sounds/freedesktop/stereo/complete.oga
}
