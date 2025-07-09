return {
	"mbbill/undotree",
	lazy = true,
	cmd = "UndotreeToggle", -- Lazy load with the UndotreeToggle command
	config = function()
		vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle Undotree" })
	end,
}
