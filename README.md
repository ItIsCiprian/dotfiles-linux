My Dev Environment Files (Linux) with GNU Stow 🚀

Opinionated dotfiles for Linux, managed via symlinks using GNU Stow.

⚠️ These are primarily for inspiration. Review before using and proceed at your own risk.

📦 Quick Start
# 1) Clone the repo anywhere (~/dotfiles-linux is common)
git clone https://github.com/ItIsCiprian/dotfiles-linux.git
cd dotfiles-linux

# 2) Preview what stow will do (dry run)
stow -nv */

# 3) Apply symlinks into $HOME (from each top-level folder, e.g. zsh, nvim, tmux, etc.)
stow .
# or cherry-pick:
stow zsh nvim tmux alacritty ghostty


If you get “conflict: existing target files”: back up or remove the conflicting files first, or run:
stow -D <pkg> to unstow, then stow <pkg> again.

🧰 Base CLI Tooling

Install these first (pick your distro section below):

zsh, git, curl, wget

fzf, fd, ripgrep

eza, bat, delta, tldr, thefuck

(optional) lazygit, zoxide, jq

Ubuntu / Debian
sudo apt update
sudo apt install -y zsh git curl wget fzf fd-find ripgrep bat \
  tldr jq
# aliases for Debian/Ubuntu package names
# fd is "fdfind" → map it in your shell if needed: alias fd=fdfind
# bat is "batcat" → alias bat=batcat
# thefuck via pipx (recommended)
sudo apt install -y pipx
pipx install thefuck
# eza & delta (via Debian bookworm backports or install from releases)
sudo apt install -y cargo
cargo install eza git-delta
# optional
sudo apt install -y lazygit

Fedora
sudo dnf install -y zsh git curl wget fzf fd-find ripgrep bat eza \
  git-delta tldr jq thefuck lazygit

Arch / Manjaro
sudo pacman -S --needed zsh git curl wget fzf fd ripgrep bat eza \
  git-delta tldr jq thefuck lazygit


tldr needs its pages: run tldr --update.

🖥️ Terminal & Fonts

You can use any true-color terminal. Two solid options:

Ghostty (Wayland/X11)

Config path (Linux): ~/.config/ghostty/config

Put your theme, font, keybinds here.

Alacritty

Config path: ~/.config/alacritty/alacritty.yml (e.g., coolnight.toml as a colors include)

Nerd Font

Install a Nerd Font (I use Meslo LG Nerd Font), then set it in your terminal:

Ubuntu/Debian: sudo apt install fonts-noto-color-emoji (extra symbols)

Otherwise download from: nerdfonts.com (or your distro’s package)

🧩 Shell (Zsh)

Relevant Files

~/.zshrc — main shell config (aliases, exports, keybinds)

Optional: ~/.zsh folder for plugins & extra sourcing

Tips

Set zsh as default: chsh -s "$(which zsh)"

If using thefuck, append eval "$(thefuck --alias)" in .zshrc

For fd/bat Debian names, add:

alias fd='fdfind'
alias bat='batcat'

🟩 Neovim

Modern setup using lazy.nvim + Mason + nvim-treesitter.

Requirements

Neovim ≥ 0.9

ripgrep (for Telescope)

Nerd Font

Node.js (for TS/JS LSPs) — recommended via nvm

Install Node via nvm (portable)

curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
# reload shell or source nvm
nvm install --lts


Relevant Files

~/.config/nvim (entire folder)

First Run

Open Neovim; lazy.nvim will sync plugins.

Mason will auto-install LSPs/formatters on demand.

If you briefly see “server failed to start”, press Enter — Mason will handle it.

Plugins (highlights)

Manager: folke/lazy.nvim

Essentials: nvim-lua/plenary.nvim, kylechui/nvim-surround, gbprod/substitute.nvim

UI: nvim-lualine/lualine.nvim, akinsho/bufferline.nvim, goolord/alpha-nvim, folke/which-key.nvim, stevearc/dressing.nvim

Files: nvim-tree/nvim-tree.lua, nvim-tree/nvim-web-devicons

FZF/Telescope: nvim-telescope/telescope.nvim, telescope-fzf-native.nvim

LSP: williamboman/mason.nvim, mason-lspconfig.nvim, neovim/nvim-lspconfig, hrsh7th/cmp-nvim-lsp

Completion: hrsh7th/nvim-cmp, cmp-buffer, cmp-path, onsails/lspkind.nvim

Snippets: L3MON4D3/LuaSnip, saadparwaiz1/cmp_luasnip, rafamadriz/friendly-snippets

Treesitter: nvim-treesitter/nvim-treesitter, nvim-treesitter-textobjects, windwp/nvim-autopairs, windwp/nvim-ts-autotag

Git: lewis6991/gitsigns.nvim, kdheepak/lazygit.nvim

Diagnostics: folke/trouble.nvim

Comments: numToStr/Comment.nvim, JoosepAlviste/nvim-ts-context-commentstring

Indent: lukas-reineke/indent-blankline.nvim

Format/Lint: stevearc/conform.nvim, mfussenegger/nvim-lint, WhoIsSethDaniel/mason-tool-installer.nvim

Colorscheme: folke/tokyonight.nvim (with small tweaks)

⌨️ Tmux

Relevant Files

~/.tmux.conf

Notes

Works great with christoomey/vim-tmux-navigator to move between tmux panes and Neovim splits with <C-h/j/k/l>.

Consider tmux-plugins/tpm if you like plugin management in tmux.
