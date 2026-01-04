#!/usr/bin/env bash
#
# Install tmux plugins via TPM (Tmux Plugin Manager)
#

set -e

echo "🔧 Installing tmux plugins..."

# Check if tmux is installed
if ! command -v tmux &> /dev/null; then
    echo "❌ Error: tmux is not installed"
    exit 1
fi

# Check if TPM is installed
if [ ! -d ~/.tmux/plugins/tpm ]; then
    echo "❌ Error: TPM is not installed at ~/.tmux/plugins/tpm"
    echo "Install it with: git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm"
    exit 1
fi

# Check if config file exists
if [ ! -f ~/.tmux.conf ]; then
    echo "❌ Error: ~/.tmux.conf not found"
    exit 1
fi

echo "✓ TPM found"
echo "✓ Config found"

# Kill any existing tmux server to start fresh
echo "Stopping any running tmux sessions..."
tmux kill-server 2>/dev/null || true

# Start a detached tmux session
echo "Starting tmux session..."
tmux new-session -d -s plugin_install

# Install plugins using TPM
echo "Installing plugins..."
~/.tmux/plugins/tpm/bin/install_plugins

# Kill the temporary session
tmux kill-session -t plugin_install 2>/dev/null || true

echo "✅ Done! Plugins installed successfully."
echo ""
echo "Start tmux and your plugins should be loaded."
