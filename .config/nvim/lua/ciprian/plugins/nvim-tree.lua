return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")

		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		nvimtree.setup({
			-- Custom sorter: directories first, then by numeric value in names, then name (case-insensitive)
			sort_by = function(nodes)
				table.sort(nodes, function(a, b)
					-- 1) directories first
					if a.type ~= b.type then
						return a.type == "directory"
					end

					-- 2) compare by first number found in names (natural sort)
					local an = tonumber(string.match(a.name, "%d+"))
					local bn = tonumber(string.match(b.name, "%d+"))
					if an and bn and an ~= bn then
						return an < bn
					elseif an and not bn then
						-- items with a number come before those without (optional; comment out if not desired)
						return true
					elseif bn and not an then
						return false
					end

					-- 3) fallback to case-insensitive alphabetical
					return a.name:lower() < b.name:lower()
				end)
			end,

			view = {
				adaptive_size = "left",
				width = 50,
				relativenumber = true,
			},

			renderer = {
				group_empty = true, -- group chains of empty folders
				indent_markers = { enable = true },
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "", -- arrow when folder is closed
							arrow_open = "", -- arrow when folder is open
						},
					},
				},
			},

			actions = {
				open_file = {
					window_picker = { enable = false },
				},
			},

			filters = {
				custom = { ".DS_Store" },
			},

			git = {
				ignore = false,
			},
		})

		-- keymaps
		local keymap = vim.keymap
		keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
		keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle explorer on current file" })
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
	end,
}
