return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	lazy = true,
	event = "VeryLazy",
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end, { desc = "Add file to harpoon list" })
		vim.keymap.set("n", "<leader>h", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Toggle harpoon quick menu" })

		vim.keymap.set("n", "<C-1>", function()
			harpoon:list():select(1)
		end, { desc = "Go to harpoon file 1" })
		vim.keymap.set("n", "<C-2>", function()
			harpoon:list():select(2)
		end, { desc = "Go to harpoon file 2" })
		vim.keymap.set("n", "<C-3>", function()
			harpoon:list():select(3)
		end, { desc = "Go to harpoon file 3" })
		vim.keymap.set("n", "<C-4>", function()
			harpoon:list():select(4)
		end, { desc = "Go to harpoon file 4" })

		-- -- Toggle previous & next buffers stored within Harpoon list
		-- vim.keymap.set("n", "<S-H>", function()
		-- 	harpoon:list():prev()
		-- end)
		-- vim.keymap.set("n", "<S-L>", function()
		-- 	harpoon:list():next()
		-- end)
	end,
}
