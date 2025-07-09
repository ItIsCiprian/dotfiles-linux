return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = true,
		event = "VeryLazy",
		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({
				-- List of parsers to install automatically
				ensure_installed = {
					"bash",
					"c",
					"diff",
					"html",
					"javascript",
					"jsdoc",
					"json",
					"jsonc",
					"lua",
					"luadoc",
					"luap",
					"markdown",
					"markdown_inline",
					"python",
					"query",
					"regex",
					"toml",
					"tsx",
					"typescript",
					"vim",
					"vimdoc",
					"yaml",
				},
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
}
