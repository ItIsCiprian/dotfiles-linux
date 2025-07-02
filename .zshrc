#!/usr/bin/env zsh
# ~/.zshrc - Zsh configuration file for Linux

# -----------------------------------------------------------------------------
# 1. Path Configuration
# -----------------------------------------------------------------------------
export PATH="$PATH:$HOME/.config/emacs/bin"

# -----------------------------------------------------------------------------
# 2. Oh My Zsh Setup
# -----------------------------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"
export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"

plugins=(
  git
  web-search
  zsh-autosuggestions
  zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh

export DOOMDIR="$HOME/.config/doom"

# -----------------------------------------------------------------------------
# 3. History Configuration
# -----------------------------------------------------------------------------
HISTFILE=$HOME/.zhistory
HISTSIZE=1000
SAVEHIST=1000

setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# -----------------------------------------------------------------------------
# 4. Key Bindings
# -----------------------------------------------------------------------------
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# -----------------------------------------------------------------------------
# 5. Package Managers (no Homebrew)
# -----------------------------------------------------------------------------
# Node Version Manager (NVM)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# -----------------------------------------------------------------------------
# 6. Tools Configuration
# -----------------------------------------------------------------------------
eval "$(fzf --zsh)"

export FZF_DEFAULT_OPTS="
  --color=fg:#CDD6F4,bg:#1E1E2E,hl:#F5C2E7,fg+:#CDD6F4,bg+:#302D41,hl+:#F5C2E7
  --color=info:#FAB387,prompt:#F5C2E7,pointer:#F28FAD,marker:#A6E3A1,spinner:#89B4FA,header:#1E1E2E
"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

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

export BAT_THEME="Catppuccin Macchiato"

eval "$(thefuck --alias)"
eval "$(thefuck --alias fk)"

# -----------------------------------------------------------------------------
# 7. Navigation Tools
# -----------------------------------------------------------------------------
eval "$(zoxide init zsh)"
alias cd="z"

# -----------------------------------------------------------------------------
# 8. Custom Aliases and Functions
# -----------------------------------------------------------------------------
alias reload-zsh="source ~/.zshrc"
alias edit-zsh="nvim ~/.zshrc"

alias vim="nvim"
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"

# -----------------------------------------------------------------------------
# 9. Terminal Integration
# -----------------------------------------------------------------------------
[ -f "$HOME/.profile" ] && source "$HOME/.profile"

# -----------------------------------------------------------------------------
# 10. Pomodoro Work and Rest Timer
# -----------------------------------------------------------------------------
work() {
  echo "▶️  Starting 60-minute work timer..."
  timer 60m
  notify-send -i "$HOME/Pictures/tomato.png" "Pomodoro 🍅" "✅ Work timer is up! Take a break 😊"
  paplay /usr/share/sounds/freedesktop/stereo/complete.oga
}

rest() {
  echo "☕  Starting 10-minute break..."
  timer 10m
  notify-send -i "$HOME/Pictures/tomato.png" "Pomodoro 🍅" "⏰ Break is over! Get back to work 😬"
  paplay /usr/share/sounds/freedesktop/stereo/complete.oga
}

