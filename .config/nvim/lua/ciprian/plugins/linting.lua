return {
	"mfussenegger/nvim-lint",
	lazy = true,
	event = "VeryLazy",
	config = function()
		local lint = require("lint")

		-- Configure linters for different filetypes
		lint.linters_by_ft = {
			-- Example configurations (uncomment and adjust as needed):
			-- javascript = { "eslint" },
			-- typescript = { "eslint" },
			-- javascriptreact = { "eslint" },
			-- typescriptreact = { "eslint" },
			-- vue = { "eslint" },
			-- svelte = { "eslint" },
			-- python = { "pylint" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
