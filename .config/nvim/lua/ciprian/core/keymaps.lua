-- [[ Keymaps ]]
local keymap = vim.keymap

-- [[ General ]]
keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
keymap.set("n", "<leader>q", ":qa<CR>", { desc = "Quit all" })

-- Better window navigation
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to down window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to up window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Resize window with arrows
keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Move selected line / block of text in visual mode
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

-- Insert mode keymaps
keymap.set("i", "jk", "<esc>", { desc = "Exit insert mode" })
keymap.set("i", "kj", "<esc>", { desc = "Exit insert mode" })
keymap.set("i", "jj", "<esc>", { desc = "Exit insert mode" })
keymap.set("i", "kk", "<esc>", { desc = "Exit insert mode" })

-- Buffer management
keymap.set("n", "<Tab>", "<C-^>", { desc = "Jump to alternate buffer" })
keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete current buffer" })

-- Scrolling
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

-- Search results navigation
keymap.set("n", "n", "nzzzv", { desc = "Next search result and center" })
keymap.set("n", "N", "Nzzzv", { desc = "Previous search result and center" })

-- Window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- [[ Plugin Keymaps (examples, actual keymaps will be in plugin configs) ]]
-- These are examples. Actual plugin keymaps should be defined within their respective plugin configuration files
-- For example, for Telescope:
-- keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
-- keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live grep" })

