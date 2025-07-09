local opt = vim.opt

-- [[ Basic Settings ]]
opt.encoding = "utf-8"          -- Set default encoding to UTF-8
opt.fileencoding = "utf-8"      -- Set file encoding to UTF-8
opt.termguicolors = true        -- Enable 24-bit RGB color in the terminal
opt.background = "dark"         -- Set background to dark (for colorschemes that support it)
opt.mouse = "a"                 -- Enable mouse support in all modes
opt.undofile = true             -- Enable persistent undo history
opt.swapfile = false            -- Disable swap files
opt.writebackup = false         -- Disable backup files
opt.backup = false              -- Disable backup files
opt.hidden = true               -- Allow hidden buffers (don't close buffer when switching)
opt.showmode = false            -- Don't show current mode in command line (statusline handles this)
opt.showcmd = false             -- Don't show incomplete commands (statusline handles this)
opt.ruler = false               -- Don't show ruler (statusline handles this)
opt.cmdheight = 1               -- Command line height
opt.updatetime = 250            -- Decrease update time (for plugins like LSP)
opt.timeoutlen = 500            -- Time to wait for a mapped sequence to complete
opt.completeopt = "menuone,noselect" -- Completion options
opt.pumheight = 10              -- Popup menu height
opt.whichwrap = "b,s,<,>,[,]"   -- Allow cursor to wrap around lines
opt.splitright = true           -- Split vertical window to the right
opt.splitbelow = true           -- Split horizontal window to the bottom
opt.inccommand = "split"        -- Live preview for :s and :global
opt.scrolloff = 5               -- Lines of context around the cursor
opt.laststatus = 2              -- Always show the statusline
opt.showtabline = 2             -- Always show the tabline
opt.signcolumn = "yes"          -- Always show the sign column

-- [[ Numbering ]]
opt.relativenumber = true       -- Relative line numbers
opt.number = true               -- Absolute line numbers
opt.numberwidth = 4             -- Minimum columns for line numbers

-- [[ Tabs & Indentation ]]
opt.tabstop = 2                 -- Number of spaces a tab counts for
opt.shiftwidth = 2              -- Number of spaces to use for autoindent
opt.softtabstop = 2             -- Number of spaces a tab counts for when editing
opt.expandtab = true            -- Use spaces instead of tabs
opt.autoindent = true           -- Auto indent new lines
opt.breakindent = true          -- Preserve indentation when wrapping lines

-- [[ Line Wrapping ]]
opt.wrap = false                -- Disable line wrapping

-- [[ Search Settings ]]
opt.ignorecase = true           -- Ignore case in search patterns
opt.smartcase = true            -- Smart case search (case-sensitive if pattern contains uppercase)
opt.hlsearch = false            -- Disable highlighting of search matches (can be toggled by plugin)
opt.incsearch = true            -- Incremental search

-- [[ Cursor Line ]]
opt.cursorline = true           -- Highlight the current line

-- [[ Backspace ]]
opt.backspace = "indent,eol,start" -- Allow backspace over autoindent, end-of-line, and start of insert

-- [[ Clipboard ]]
opt.clipboard:append("unnamedplus") -- Use system clipboard as default register

-- [[ Global Variables ]]
vim.g.mapleader = " "           -- Set mapleader to space
vim.g.have_nerd_font = true     -- Indicate that a Nerd Font is available
vim.g.colorscheme = "catppuccin" -- Default colorscheme
