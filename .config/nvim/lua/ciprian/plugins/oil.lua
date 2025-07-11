return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	lazy = true,
	cmd = "Oil", -- Lazy load with the Oil command
	-- Optional dependencies
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
	config = function()
		require("oil").setup()

		local keymap = vim.keymap -- for conciseness
		keymap.set("n", "-", "<cmd>Oil --float<CR>", { desc = "Open Parent Directory in Oil -float" })
	end,
}
