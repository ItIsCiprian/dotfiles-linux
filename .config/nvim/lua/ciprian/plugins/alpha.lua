return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		dashboard.section.header.val = {
			" ",
			"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
			"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
			"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
			"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
			"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
			"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
			" ",
		}

		dashboard.section.buttons.val = {
			dashboard.button("e", "  New File", ":ene <BAR> startinsert<CR>"),
			dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
		}

		-- Footer with stats
		local stats = require("lazy").stats()
		dashboard.section.footer.val = {
			"",
			"⚡ Loaded " .. stats.count .. " plugins in " .. math.floor(stats.startuptime * 100) / 100 .. "ms",
			"🧠 Welcome, Ciprian — powered by Lazy.nvim",
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
