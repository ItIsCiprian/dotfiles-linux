return {
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre", -- Lazy load on buffer read
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"tpope/vim-fugitive",
		cmd = "Git", -- Lazy load when Git command is used
	},
}
