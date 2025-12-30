
#!/usr/bin/env zsh
# ~/.zshrc - Zsh configuration file for Linux

# -----------------------------------------------------------------------------
# 0. PATH: early additions (pipx/user bin first so tools are found)
# -----------------------------------------------------------------------------
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# -----------------------------------------------------------------------------
# 1. Environment Variables
# -----------------------------------------------------------------------------
export EDITOR='nvim'
export NVIM_THEME='catppuccin'
export DOOMDIR="$HOME/.config/doom"
export HISTFILE="$HOME/.zhistory"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

export NVM_DIR="$HOME/.nvm"
export ANDROID_HOME="$HOME/Android"
export JAVA_HOME="/usr/lib/jvm/java-24-openjdk"

# -----------------------------------------------------------------------------
# 2. PATH Configuration (append only if dirs exist)
# -----------------------------------------------------------------------------
typeset -a PATH_ENTRIES
PATH_ENTRIES=(
  "$HOME/.config/emacs/bin"
  "$HOME/flutter/bin"
)

[[ -d "$JAVA_HOME/bin" ]] && PATH_ENTRIES+=("$JAVA_HOME/bin")

if [[ -d "$ANDROID_HOME" ]]; then
  [[ -d "$ANDROID_HOME/emulator" ]] && PATH_ENTRIES+=("$ANDROID_HOME/emulator")
  [[ -d "$ANDROID_HOME/platform-tools" ]] && PATH_ENTRIES+=("$ANDROID_HOME/platform-tools")
  [[ -d "$ANDROID_HOME/cmdline-tools/latest/bin" ]] && PATH_ENTRIES+=("$ANDROID_HOME/cmdline-tools/latest/bin")
fi

# Prepend PATH_ENTRIES in front of PATH (only once)
for p in "${PATH_ENTRIES[@]}"; do
  [[ -d "$p" ]] && path=("$p" $path)
done
export PATH

# -----------------------------------------------------------------------------
# 3. Oh My Zsh Setup
# -----------------------------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"

# Load Starship prompt (only if installed)
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

plugins=(
  git
  web-search
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Load Oh My Zsh if installed
if [[ -f "$ZSH/oh-my-zsh.sh" ]]; then
  source "$ZSH/oh-my-zsh.sh"
fi

# -----------------------------------------------------------------------------
# 4. History Configuration
# -----------------------------------------------------------------------------
HISTSIZE=1000
SAVEHIST=1000

setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# -----------------------------------------------------------------------------
# 5. Key Bindings
# -----------------------------------------------------------------------------
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# -----------------------------------------------------------------------------
# 6. Package Manager / Language Tools
# -----------------------------------------------------------------------------
# Load NVM if installed
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

# -----------------------------------------------------------------------------
# 7. Tools Configuration
# -----------------------------------------------------------------------------
# fzf init (only if installed)
if command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --zsh)"
fi

# fzf options (safe even if fzf not installed)
export FZF_DEFAULT_OPTS="
  --color=fg:#CDD6F4,bg:#1E1E2E,hl:#F5C2E7,fg+:#CDD6F4,bg+:#302D41,hl+:#F5C2E7
  --color=info:#FAB387,prompt:#F5C2E7,pointer:#F28FAD,marker:#A6E3A1,spinner:#89B4FA,header:#1E1E2E
"

# Prefer fd/bat/eza when present; fall back gracefully
if command -v fd >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

  _fzf_compgen_path() { fd --hidden --exclude .git . "$1" }
  _fzf_compgen_dir()  { fd --type=d --hidden --exclude .git . "$1" }
else
  export FZF_DEFAULT_COMMAND="find . -type f 2>/dev/null"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="find . -type d 2>/dev/null"
fi

if command -v bat >/dev/null 2>&1; then
  export BAT_THEME="Catppuccin Macchiato"
  export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
else
  export FZF_CTRL_T_OPTS=""
fi

if command -v eza >/dev/null 2>&1; then
  export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
else
  export FZF_ALT_C_OPTS=""
fi

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)
      if command -v eza >/dev/null 2>&1; then
        fzf --preview 'eza --tree --color=always {} | head -200' "$@"
      else
        fzf "$@"
      fi
      ;;
    export|unset) fzf --preview "eval 'echo ${}'" "$@" ;;
    ssh)
      if command -v dig >/dev/null 2>&1; then
        fzf --preview 'dig {}' "$@"
      else
        fzf "$@"
      fi
      ;;
    *)
      if command -v bat >/dev/null 2>&1; then
        fzf --preview "bat -n --color=always --line-range :500 {}" "$@"
      else
        fzf "$@"
      fi
      ;;
  esac
}

# thefuck (guarded so it can’t break your shell)
#if command -v thefuck >/dev/null 2>&1; then
#  eval "$(thefuck --alias)"
#  eval "$(thefuck --alias fk)"
#fi

# zoxide (guarded)
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
  alias cd="z"
fi

# -----------------------------------------------------------------------------
# 8. Navigation and Aliases
# -----------------------------------------------------------------------------
alias reload-zsh="source ~/.zshrc"
alias edit-zsh="nvim ~/.zshrc"
alias vim="nvim"

if command -v eza >/dev/null 2>&1; then
  alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
fi

# -----------------------------------------------------------------------------
# 9. Terminal Integration
# -----------------------------------------------------------------------------
[[ -f "$HOME/.profile" ]] && source "$HOME/.profile"

# -----------------------------------------------------------------------------
# 10. Pomodoro Timer Functions
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
