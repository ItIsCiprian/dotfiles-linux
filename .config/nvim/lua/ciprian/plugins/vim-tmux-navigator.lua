return {
	"christoomey/vim-tmux-navigator",
	cmd = {
		"TmuxNavigateLeft",
		"TmuxNavigateDown",
		"TmuxNavigateUp",
		"TmuxNavigateRight",
		"TmuxNavigatePrevious",
	},
	keys = {
		{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", desc = "Navigate to left pane" },
		{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", desc = "Navigate to down pane" },
		{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", desc = "Navigate to up pane" },
		{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", desc = "Navigate to right pane" },
		{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>", desc = "Navigate to previous pane" },
	},
}
