#!/usr/bin/env zsh
# ~/.zshrc — Zsh configuration (Fedora Linux)

# ─── Guard: skip for non-interactive shells ───────────────────────────────────
[[ $- != *i* ]] && return

# ─── Helper ───────────────────────────────────────────────────────────────────
# Usage: has <cmd>  →  returns 0 if the command exists
has() { command -v "$1" &>/dev/null }

# ─── 1. Environment Variables ─────────────────────────────────────────────────
export EDITOR='nvim'
export VISUAL='nvim'
export NVIM_THEME='catppuccin'
export DOOMDIR="$HOME/.config/doom"
export HISTFILE="$HOME/.zhistory"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
export ANDROID_HOME="$HOME/Android"
export JAVA_HOME="/usr/lib/jvm/java-24-openjdk"  # update when upgrading JDK
export NVM_DIR="$HOME/.nvm"

# XDG base dirs (many tools respect these)
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# ─── 2. PATH ──────────────────────────────────────────────────────────────────
# `typeset -U path` auto-deduplicates entries — no manual checks needed.
typeset -U path

path=(
  "$HOME/.local/bin"
  "$HOME/bin"
  "$HOME/.config/emacs/bin"
  "$HOME/flutter/bin"
  $path
)

# Java
[[ -d "$JAVA_HOME/bin" ]] && path=("$JAVA_HOME/bin" $path)

# Android SDK
if [[ -d "$ANDROID_HOME" ]]; then
  path=(
    "$ANDROID_HOME/emulator"
    "$ANDROID_HOME/platform-tools"
    "$ANDROID_HOME/cmdline-tools/latest/bin"
    $path
  )
fi

# ─── 3. History ───────────────────────────────────────────────────────────────
HISTSIZE=50000
SAVEHIST=50000

setopt share_history          # sync history across sessions
setopt hist_expire_dups_first # expire duplicates first when trimming
setopt hist_ignore_dups       # don't record consecutive duplicates
setopt hist_ignore_space      # skip commands prefixed with a space
setopt hist_reduce_blanks     # strip extra whitespace before saving
setopt hist_verify            # let you edit the recalled command first
setopt extended_history       # record timestamps

# ─── 4. Oh My Zsh ────────────────────────────────────────────────────────────
# Starship handles the prompt, so ZSH_THEME is intentionally empty.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""

plugins=(
  git
  web-search
  zsh-autosuggestions
  zsh-syntax-highlighting
  dnf                 # dnf aliases (built-in OMZ plugin)
  systemd             # systemctl aliases (built-in OMZ plugin)
  sudo                # press ESC twice to prepend sudo
  copyfile            # `copyfile <file>` copies contents to clipboard
)

[[ -f "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

# Starship prompt (after OMZ so it wins the PROMPT race)
has starship && eval "$(starship init zsh)"

# ─── 5. Key Bindings ──────────────────────────────────────────────────────────
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^[[H' beginning-of-line   # Home
bindkey '^[[F' end-of-line         # End
bindkey '^[[3~' delete-char        # Delete

# ─── 6. NVM ───────────────────────────────────────────────────────────────────
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
  source "$NVM_DIR/nvm.sh"
  [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
fi

# ─── 7. fzf ───────────────────────────────────────────────────────────────────
if has fzf; then
  eval "$(fzf --zsh)"

  export FZF_DEFAULT_OPTS="
    --color=fg:#CDD6F4,bg:#1E1E2E,hl:#F5C2E7
    --color=fg+:#CDD6F4,bg+:#302D41,hl+:#F5C2E7
    --color=info:#FAB387,prompt:#F5C2E7,pointer:#F28FAD
    --color=marker:#A6E3A1,spinner:#89B4FA,header:#1E1E2E
    --bind='ctrl-/:toggle-preview'
    --layout=reverse --border=rounded
  "

  # Use fd when available; fall back to find
  if has fd; then
    _fd_base="fd --hidden --strip-cwd-prefix --exclude .git"
    export FZF_DEFAULT_COMMAND="$_fd_base"
    export FZF_CTRL_T_COMMAND="$_fd_base"
    export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

    _fzf_compgen_path() { fd --hidden --exclude .git . "$1" }
    _fzf_compgen_dir()  { fd --type=d --hidden --exclude .git . "$1" }
  else
    export FZF_DEFAULT_COMMAND="find . -type f 2>/dev/null"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="find . -type d 2>/dev/null"
  fi

  # Preview: bat for files, eza for dirs
  has bat && export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
  has eza && export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

  _fzf_comprun() {
    local cmd=$1; shift
    case "$cmd" in
      cd)     has eza && fzf --preview 'eza --tree --color=always {} | head -200' "$@" || fzf "$@" ;;
      export|unset)  fzf --preview 'eval echo ${{}}'  "$@" ;;
      ssh)    has dig && fzf --preview 'dig {}'        "$@" || fzf "$@" ;;
      *)      has bat && fzf --preview 'bat -n --color=always --line-range :500 {}' "$@" || fzf "$@" ;;
    esac
  }
fi

# bat theme
has bat && export BAT_THEME="Catppuccin Macchiato"

# ─── 8. zoxide ────────────────────────────────────────────────────────────────
if has zoxide; then
  eval "$(zoxide init zsh)"
  alias cd="z"
  alias cdi="zi"  # interactive selection
fi

# ─── 9. Aliases ───────────────────────────────────────────────────────────────

# Shell
alias reload-zsh="source ~/.zshrc"
alias edit-zsh="$EDITOR ~/.zshrc"
alias vim="nvim"
alias v="nvim"

# eza (drop-in ls replacement)
if has eza; then
  alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
  alias la="eza --color=always --long --git --icons=always --all"
  alias lt="eza --color=always --tree --icons=always --git-ignore"
  alias l="eza --color=always --icons=always"
fi

# bat (drop-in cat replacement)
has bat && alias cat="bat --paging=never"

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Fedora / DNF
# (The OMZ `dnf` plugin covers common shortcuts; these add Fedora-specific ones)
alias dnfu="sudo dnf upgrade --refresh"     # full system upgrade
alias dnfc="sudo dnf autoremove && sudo dnf clean all"  # clean up
alias dnfh="dnf history"
alias copr-enable="sudo dnf copr enable"   # quick COPR access

# Systemd (OMZ `systemd` plugin adds sc-* aliases; extras below)
alias jctl="journalctl -xe"                # recent journal with context
alias jctlf="journalctl -f"               # follow logs
alias failed="systemctl --failed"          # list failed units

# Flatpak
has flatpak && alias fpak="flatpak"

# Disk / system
alias df="df -hT --exclude-type=tmpfs --exclude-type=devtmpfs"
alias du="du -sh"
alias free="free -h"
alias psa="ps aux | grep"

# Network
alias myip="curl -s https://ifconfig.me && echo"
alias ports="ss -tulanp"

# Git
alias gs="git status"
alias glog="git log --oneline --graph --decorate --all"

# Safety nets
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# ─── 10. Pomodoro Timer ───────────────────────────────────────────────────────
# Requires: `timer` (https://github.com/caarlos0/timer) + libnotify + pipewire/pulseaudio
_pomo_notify() {
  local icon="$HOME/Pictures/tomato.png"
  local title="Pomodoro 🍅"
  notify-send ${[[ -f "$icon" ]] && echo "-i $icon"} "$title" "$1"
  # Try pipewire-pulse first, then pulseaudio
  paplay /usr/share/sounds/freedesktop/stereo/complete.oga 2>/dev/null || true
}

work() {
  local mins=${1:-60}
  echo "▶️  Starting ${mins}-minute work session..."
  timer "${mins}m" && _pomo_notify "✅ Work timer is up! Take a break 😊"
}

rest() {
  local mins=${1:-10}
  echo "☕  Starting ${mins}-minute break..."
  timer "${mins}m" && _pomo_notify "⏰ Break over! Get back to it 😬"
}

# ─── 11. Source local overrides (machine-specific, untracked) ─────────────────
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
[[ -f "$HOME/.profile"     ]] && source "$HOME/.profile"
