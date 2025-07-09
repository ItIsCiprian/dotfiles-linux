return { -- Collection of various small independent plugins/modules
	"echasnovski/mini.nvim",
	lazy = true,
	event = "VeryLazy",
	config = function()
		-- Mini.ai: Textobject for selecting and manipulating arguments, blocks, etc.
		require("mini.ai").setup({ n_lines = 500 })

		-- Mini.surround: Add/delete/replace surroundings (brackets, quotes, etc.)
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		require("mini.surround").setup()

		-- Mini.pairs: Autoclose and autopair brackets, quotes, etc.
		require("mini.pairs").setup()

		-- Mini.statusline: Minimalistic and fast statusline
		require("mini.statusline").setup()

		-- Uncomment and configure if you want to use these modules:
		-- require("mini.animate").setup()
		-- require("mini.comment").setup()
	end,
}
