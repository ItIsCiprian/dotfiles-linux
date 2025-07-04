return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		local snacks = require("snacks") -- only if you want to hook in later

		dashboard.section.header.val = {
			" ",
			" ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
			" ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
			" ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
			" ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
			" ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
			" ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
			" ",
		}

		dashboard.section.buttons.val = {
			-- Snacks / Telescope-style buttons
			dashboard.button("<leader><leader>", "  Buffers", "<cmd>lua Snacks.picker.buffers()<CR>"),
			dashboard.button("<leader>sf", "  Find Files", "<cmd>lua Snacks.picker.files()<CR>"),
			dashboard.button("<leader>sr", "  Recent Files", "<cmd>lua Snacks.picker.recent()<CR>"),
			dashboard.button("<leader>sg", "󰱽  Grep Word", "<cmd>lua Snacks.picker.grep()<CR>"),
			dashboard.button("<leader>fg", "  Git Files", "<cmd>lua Snacks.picker.git_files()<CR>"),
			dashboard.button("<leader>gs", "󰊢  Git Status", "<cmd>lua Snacks.picker.git_status()<CR>"),
			dashboard.button("<leader>lg", "  LazyGit", "<cmd>lua Snacks.lazygit()<CR>"),
			dashboard.button("e", "  New File", "<cmd>ene <BAR> startinsert<CR>"),
			dashboard.button("q", "  Quit Neovim", "<cmd>qa<CR>"),
		}

		-- Footer with stats
		local stats = require("lazy").stats()
		dashboard.section.footer.val = {
			"",
			"⚡ Loaded " .. stats.count .. " plugins in " .. math.floor(stats.startuptime * 100) / 100 .. "ms",
			"🧠 Welcome, Ciprian — powered by Snacks & Lazy",
			"",
			"",
		}

		dashboard.section.header.opts = { position = "center" }
		dashboard.section.buttons.opts = { position = "center" }
		dashboard.section.footer.opts = { position = "center" }

		alpha.setup(dashboard.opts)

		-- Avoid fold issues in alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
