---@diagnostic disable: missing-fields

-- Theme switching function
local function set_theme(theme_name)
	vim.cmd("colorscheme " .. theme_name)
	-- Save the current theme preference
	vim.g.current_theme = theme_name
end

-- Auto theme detection based on terminal/system (adjusted for WSL)
local function detect_theme()
	-- Check terminal background color (approximate method)
	local bg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Normal")), "bg")
	if bg and bg:lower() == "#000000" then
		return "dark"
	elseif bg and bg:lower() == "#ffffff" then
		return "light"
	end

	-- Fallback to vim's background setting
	return vim.o.background or "dark"
end

return {
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function()
			local transparent = false
			local bg = "#011628"
			local bg_dark = "#011423"
			local bg_highlight = "#143652"
			local bg_search = "#0A64AC"
			local bg_visual = "#275378"
			local fg = "#CBE0F0"
			local fg_dark = "#B4D0E9"
			local fg_gutter = "#627E97"
			local border = "#547998"

			require("tokyonight").setup({
				style = "night",
				transparent = transparent,
				styles = {
					sidebars = transparent and "transparent" or "dark",
					floats = transparent and "transparent" or "dark",
				},
				on_colors = function(colors)
					colors.bg = bg
					colors.bg_dark = transparent and colors.none or bg_dark
					colors.bg_float = transparent and colors.none or bg_dark
					colors.bg_highlight = bg_highlight
					colors.bg_popup = bg_dark
					colors.bg_search = bg_search
					colors.bg_sidebar = transparent and colors.none or bg_dark
					colors.bg_statusline = transparent and colors.none or bg_dark
					colors.bg_visual = bg_visual
					colors.border = border
					colors.fg = fg
					colors.fg_dark = fg_dark
					colors.fg_float = fg
					colors.fg_gutter = fg_gutter
					colors.fg_sidebar = fg_dark
				end,
			})
		end,
	},
	{
		"thesimonho/kanagawa-paper.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			require("kanagawa-paper").setup({
				undercurl = true,
				transparent = true,
				gutter = false,
				dimInactive = false,
				terminalColors = true,
				commentStyle = { italic = true },
				functionStyle = { italic = false },
				keywordStyle = { italic = false, bold = false },
				statementStyle = { italic = false, bold = false },
				typeStyle = { italic = false },
				colors = { theme = {}, palette = {} },
				overrides = function()
					return {}
				end,
			})
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
		config = function()
			require("kanagawa").setup({
				transparent = true,
				colors = {
					theme = {
						all = {
							ui = {
								bg_gutter = "none",
							},
						},
					},
				},
				overrides = function(colors)
					local theme = colors.theme
					return {
						NormalFloat = { bg = "none" },
						FloatBorder = { bg = "none" },
						FloatTitle = { bg = "none" },
						NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
						LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
						MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
					}
				end,
			})
		end,
	},
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "macchiato",
				background = {
					light = "latte",
					dark = "macchiato",
				},
				transparent_background = false,
				show_end_of_buffer = false,
				term_colors = false,
			})
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				variant = "main",
				dark_variant = "main",
				extend_background_behind_borders = true,
				styles = {
					bold = true,
					italic = true,
					transparency = true,
				},
			})
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				terminal_colors = true,
				undercurl = true,
				underline = true,
				bold = true,
				italic = {
					strings = true,
					emphasis = true,
					comments = true,
					operators = false,
					folds = true,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true,
				contrast = "",
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = false,
			})
		end,
	},

	-- Theme management configuration
	{
		"folke/lazy.nvim",
		opts = function(_, opts)
			vim.api.nvim_create_autocmd("VimEnter", {
				callback = function()
					local themes = {
						tokyonight = "tokyonight",
						kanagawa = "kanagawa-dragon",
						kanagawa_paper = "kanagawa-paper",
						catppuccin = "catppuccin",
						rose_pine = "rose-pine",
						gruvbox = "gruvbox",
					}

					for name, colorscheme in pairs(themes) do
						vim.api.nvim_create_user_command(
							"Theme" .. name:gsub("^%l", string.upper):gsub("_(%l)", string.upper),
							function()
								set_theme(colorscheme)
							end,
							{}
						)
					end

					vim.api.nvim_create_user_command("ThemeSwitch", function(opts)
						local theme = opts.args
						if themes[theme] then
							set_theme(themes[theme])
						else
							print("Available themes: " .. table.concat(vim.tbl_keys(themes), ", "))
						end
					end, {
						nargs = 1,
						complete = function()
							return vim.tbl_keys(themes)
						end,
					})

					vim.api.nvim_create_user_command("ThemeAuto", function()
						local detected = detect_theme()
						if detected == "dark" then
							set_theme("catppuccin")
						else
							set_theme("catppuccin")
						end
						print("Auto-detected theme: " .. detected)
					end, {})

					vim.api.nvim_create_user_command("ThemeToggle", function()
						local current = vim.g.colors_name or ""
						local light_themes = { "catppuccin", "rose-pine-dawn", "kanagawa-paper" }
						local dark_themes = { "tokyonight", "kanagawa-dragon", "gruvbox", "rose-pine" }

						local is_light = vim.tbl_contains(light_themes, current)
						if is_light then
							set_theme(dark_themes[1])
						else
							set_theme(light_themes[1])
						end
					end, {})

					vim.keymap.set("n", "<leader>tt", ":ThemeToggle<CR>", { desc = "Toggle light/dark theme" })
					vim.keymap.set("n", "<leader>ta", ":ThemeAuto<CR>", { desc = "Auto-detect theme" })
					vim.keymap.set("n", "<leader>ts", ":ThemeSwitch ", { desc = "Switch theme" })

					local auto_theme = os.getenv("NVIM_THEME")
					if auto_theme and themes[auto_theme] then
						set_theme(themes[auto_theme])
					else
						set_theme("catppuccin")
					end
				end,
			})

			return opts
		end,
	},
}
