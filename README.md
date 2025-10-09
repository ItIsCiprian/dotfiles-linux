# 🧰 My Dev Environment Files (Linux) with GNU Stow 🚀

Opinionated **dotfiles** for Linux — organized, modular, and symlinked using [GNU Stow](https://www.gnu.org/software/stow/).

> ⚠️ **Disclaimer:** These configurations are primarily for inspiration. Review them carefully and use at your own risk.

---

## 📦 Quick Start

```bash
# 1️⃣ Clone the repo
git clone https://github.com/ItIsCiprian/dotfiles-linux.git ~/dotfiles-linux
cd ~/dotfiles-linux

# 2️⃣ Preview what Stow will do (dry run)
stow -nv */

# 3️⃣ Apply symlinks into $HOME
stow .
# or apply specific modules
stow zsh nvim tmux alacritty ghostty
```

> 💡 If you encounter conflicts, back up or remove existing files first.  
> To remove links: `stow -D <package>`.

---

## 🧩 Base CLI Tooling

Install these core command-line tools first:

| Category | Tools |
|-----------|-------|
| Shell & Utilities | `zsh`, `git`, `curl`, `wget` |
| Navigation | `fzf`, `fd`, `ripgrep` |
| Pretty Output | `bat`, `eza`, `delta`, `tldr` |
| Helpers | `jq`, `thefuck`, `lazygit`, `zoxide` *(optional)* |

---

### 🐧 Ubuntu / Debian

```bash
sudo apt update
sudo apt install -y zsh git curl wget fzf fd-find ripgrep bat tldr jq

# Debian naming quirks
alias fd='fdfind'
alias bat='batcat'

# thefuck (via pipx)
sudo apt install -y pipx
pipx install thefuck

# eza & delta (via cargo if missing)
sudo apt install -y cargo
cargo install eza git-delta

# optional
sudo apt install -y lazygit
```

---

### 🦊 Fedora

```bash
sudo dnf install -y zsh git curl wget fzf fd-find ripgrep bat eza   git-delta tldr jq thefuck lazygit
```

---

### 🐉 Arch / Manjaro

```bash
sudo pacman -S --needed zsh git curl wget fzf fd ripgrep bat eza   git-delta tldr jq thefuck lazygit
```

> ⚙️ Run `tldr --update` after installation.

---

## 🖥️ Terminal & Fonts

### 🪄 Ghostty (Wayland/X11)
Config file:  
`~/.config/ghostty/config`

Customize fonts, colors, and keybinds here.

---

### 🦋 Alacritty
Config file:  
`~/.config/alacritty/alacritty.yml`

Supports `.toml` color themes like `coolnight.toml`.

---

### 🔡 Nerd Font
Install a Nerd Font (e.g., **Meslo LG Nerd Font**) for icons and glyphs.

```bash
# Example for Debian / Ubuntu
sudo apt install fonts-noto-color-emoji
# or download manually from https://www.nerdfonts.com/
```

Set it in your terminal preferences.

---

## 🐚 Zsh Setup

**Relevant Files**
- `~/.zshrc` — main shell configuration  
- `~/.zsh/` — extra sourced scripts and plugins  

**Tips**

```bash
chsh -s "$(which zsh)"   # make zsh the default shell
```

Add helpful aliases:

```zsh
alias fd='fdfind'
alias bat='batcat'
eval "$(thefuck --alias)"
```

---

## 🟩 Neovim Setup

Modern Neovim powered by **lazy.nvim**, **Mason**, and **Treesitter**.

### Requirements

- Neovim ≥ 0.9  
- `ripgrep` (for Telescope)  
- Nerd Font  
- Node.js (for TypeScript / JavaScript LSPs)

Install Node via `nvm`:

```bash
curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
nvm install --lts
```

---

### Config Location

```
~/.config/nvim/
```

---

### First Run

1. Open Neovim.  
2. Let **lazy.nvim** sync plugins.  
3. Wait for **Mason** to install LSPs.  
4. If you see “server failed to start”, press **Enter** — Mason will finish setup.

---

### 🧠 Plugin Highlights

| Category | Plugins |
|-----------|----------|
| **Plugin Manager** | `folke/lazy.nvim` |
| **Core Utils** | `nvim-lua/plenary.nvim`, `kylechui/nvim-surround`, `gbprod/substitute.nvim` |
| **UI / UX** | `nvim-lualine/lualine.nvim`, `akinsho/bufferline.nvim`, `goolord/alpha-nvim`, `folke/which-key.nvim`, `stevearc/dressing.nvim` |
| **Files & Icons** | `nvim-tree/nvim-tree.lua`, `nvim-tree/nvim-web-devicons` |
| **Fuzzy Finder** | `nvim-telescope/telescope.nvim`, `nvim-telescope/telescope-fzf-native.nvim` |
| **LSP / Autocomplete** | `williamboman/mason.nvim`, `mason-lspconfig.nvim`, `neovim/nvim-lspconfig`, `hrsh7th/cmp-nvim-lsp` |
| **Completion Sources** | `hrsh7th/nvim-cmp`, `cmp-buffer`, `cmp-path`, `onsails/lspkind.nvim` |
| **Snippets** | `L3MON4D3/LuaSnip`, `saadparwaiz1/cmp_luasnip`, `rafamadriz/friendly-snippets` |
| **Syntax & Tags** | `nvim-treesitter/nvim-treesitter`, `nvim-treesitter-textobjects`, `windwp/nvim-autopairs`, `windwp/nvim-ts-autotag` |
| **Git Integration** | `lewis6991/gitsigns.nvim`, `kdheepak/lazygit.nvim` |
| **Diagnostics** | `folke/trouble.nvim` |
| **Comments** | `numToStr/Comment.nvim`, `JoosepAlviste/nvim-ts-context-commentstring` |
| **Indent & Formatting** | `lukas-reineke/indent-blankline.nvim`, `stevearc/conform.nvim`, `mfussenegger/nvim-lint`, `WhoIsSethDaniel/mason-tool-installer.nvim` |
| **Colorscheme** | `folke/tokyonight.nvim` *(custom-tweaked)* |

---

## ⌨️ Tmux Setup

**Relevant Files**
- `~/.tmux.conf`

**Notes**
- Navigate between tmux panes + Neovim splits using [`christoomey/vim-tmux-navigator`](https://github.com/christoomey/vim-tmux-navigator).  
- Optionally manage tmux plugins with `tmux-plugins/tpm`.

---

## 🪟 Window Managers for Linux

macOS-only tools (Yabai, skhd, Aerospace, SketchyBar) are replaced with Linux equivalents:

| Platform | Window Manager | Bar | Hotkeys |
|-----------|----------------|-----|----------|
| **Wayland** | `sway` or `hyprland` | `waybar` | built-in / config-based |
| **X11** | `i3` or `bspwm` | `polybar` | `sxhkd` |

**Typical Config Paths**

```
~/.config/sway/
~/.config/hypr/
~/.config/i3/
~/.config/bspwm/
~/.config/waybar/
~/.config/polybar/
~/.config/sxhkd/
```

> 🧩 Stow only the folders for the WM you actually use.

---

## 🧱 Repo Structure & Stow Packages

```
dotfiles-linux/
├─ alacritty/            → ~/.config/alacritty/
├─ ghostty/              → ~/.config/ghostty/
├─ nvim/                 → ~/.config/nvim/
├─ tmux/                 → ~/.tmux.conf
├─ zsh/                  → ~/.zshrc / ~/.zsh/*
├─ sway/ | hypr/ | i3/   → ~/.config/<wm>/
├─ waybar/ | polybar/    → ~/.config/<bar>/
└─ README.md
```

Each folder represents a **Stow package** that mirrors your `$HOME` structure.

---

## 💡 Extras

| Tool | Purpose |
|------|----------|
| **fzf-git** | Git-aware fuzzy search |
| **zoxide** | Smarter `cd` replacement |
| **bat + delta** | Prettier `cat` and `diff` |
| **tldr** | Concise command examples |
| **thefuck** | Corrects mistyped commands |
| **lazygit** | Terminal Git UI |

---

## 🧪 Troubleshooting

| Issue | Fix |
|-------|-----|
| **Stow creates links in wrong place** | Run `stow` from repo root; ensure folder structure mirrors `$HOME`. |
| **LSP “server failed”** | Press **Enter** — Mason will auto-install the server. |
| **Fonts appear broken** | Ensure terminal + bar use a Nerd Font. |
| **Wayland/X11 mismatch** | Use matching WM + bar (e.g., `Sway + Waybar`, `i3 + Polybar`). |

---

## 🔗 Reference

This setup is maintained at:  
👉 [**github.com/ItIsCiprian/dotfiles-linux**](https://github.com/ItIsCiprian/dotfiles-linux)

---

### ☕ Made with Coffee & Code by [ItIsCiprian](https://github.com/ItIsCiprian)
