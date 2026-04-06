#!/usr/bin/env bash
# install-plugins.sh — Bootstrap TPM and install all tmux plugins
set -euo pipefail

# ─── Paths (XDG-aligned, matches tmux.conf) ───────────────────────────────────
TPM_DIR="${TMUX_PLUGIN_MANAGER_PATH:-$HOME/.config/tmux/plugins}/tpm"
TMUX_CONF="${XDG_CONFIG_HOME:-$HOME/.config}/tmux/tmux.conf"
TPM_INSTALL="$TPM_DIR/bin/install_plugins"

# ─── Helpers ──────────────────────────────────────────────────────────────────
info()  { echo "  $*"; }
ok()    { echo "✔  $*"; }
fail()  { echo "✘  $*" >&2; exit 1; }

# ─── Preflight checks ─────────────────────────────────────────────────────────
echo "── tmux plugin installer ─────────────────────────────────"

command -v tmux &>/dev/null       || fail "tmux is not installed"
[[ -f "$TMUX_CONF"   ]]           || fail "config not found: $TMUX_CONF"
[[ -x "$TPM_INSTALL" ]]           || fail "TPM not found at $TPM_DIR
       Install it with:
         git clone --depth=1 https://github.com/tmux-plugins/tpm \"$TPM_DIR\""

ok "tmux $(tmux -V | cut -d' ' -f2)"
ok "config  $TMUX_CONF"
ok "TPM     $TPM_DIR"
echo

# ─── Install ──────────────────────────────────────────────────────────────────

# TPM's install_plugins requires a running server with the config loaded.
# We start a throwaway detached session, run the installer, then clean up.

SESSION="__tpm_install_$$"

info "Starting temporary tmux session ($SESSION)..."
tmux -f "$TMUX_CONF" new-session -d -s "$SESSION"

info "Running TPM install..."
"$TPM_INSTALL"

info "Cleaning up..."
tmux kill-session -t "$SESSION" 2>/dev/null || true

echo
echo "✔  All plugins installed. Start tmux normally to use them."
