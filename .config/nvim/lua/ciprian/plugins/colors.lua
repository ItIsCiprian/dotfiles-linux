---@diagnostic disable: missing-fields

-- Theme switching function
local function set_theme(theme_name)
  vim.cmd("colorscheme " .. theme_name)
  -- Save the current theme preference
  vim.g.current_theme = theme_name
end

-- Auto theme detection based on terminal/system
local function detect_theme()
  -- Check if running in a terminal that supports background detection
  local bg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Normal")), "bg")

  -- Try to detect system theme (works on some terminals)
  local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
  if handle then
    local system_theme = handle:read("*a")
    handle:close()
    if string.match(system_theme, "Dark") then
      return "dark"
    else
      return "light"
    end
  end

  -- Fallback to vim's background setting
  return vim.o.background or "dark"
end

return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      local transparent = false -- set to true if you would like to enable transparency
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
        dimInactive = false, -- disabled when transparent
        terminalColors = true,
        commentStyle = { italic = true },
        functionStyle = { italic = false },
        keywordStyle = { italic = false, bold = false },
        statementStyle = { italic = false, bold = false },
        typeStyle = { italic = false },
        colors = { theme = {}, palette = {} }, -- override default palette and theme colors
        overrides = function() -- override highlight groups
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
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = "latte",
          dark = "mocha",
        },
        transparent_background = false, -- disables setting the background color.
        show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
        term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
      })
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        variant = "main", -- auto, main, moon, or dawn
        dark_variant = "main", -- main, moon, or dawn
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
        terminal_colors = true, -- add neovim terminal colors
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
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "", -- can be "hard", "soft" or empty string
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
      -- Set up theme switching commands and keymaps after all themes are loaded
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          -- Available themes
          local themes = {
            tokyonight = "tokyonight",
            kanagawa = "kanagawa-dragon",
            kanagawa_paper = "kanagawa-paper",
            catppuccin = "catppuccin",
            rose_pine = "rose-pine",
            gruvbox = "gruvbox",
          }

          -- Create commands for each theme
          for name, colorscheme in pairs(themes) do
            vim.api.nvim_create_user_command(
              "Theme" .. name:gsub("^%l", string.upper):gsub("_(%l)", string.upper),
              function()
                set_theme(colorscheme)
              end,
              {}
            )
          end

          -- Theme switcher command with completion
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

          -- Auto theme detection command
          vim.api.nvim_create_user_command("ThemeAuto", function()
            local detected = detect_theme()
            if detected == "dark" then
              set_theme("tokyonight") -- or your preferred dark theme
            else
              set_theme("catppuccin") -- or your preferred light theme
            end
            print("Auto-detected theme: " .. detected)
          end, {})

          -- Toggle between light and dark themes
          vim.api.nvim_create_user_command("ThemeToggle", function()
            local current = vim.g.colors_name or ""
            local light_themes = { "catppuccin", "rose-pine-dawn", "kanagawa-paper" }
            local dark_themes = { "tokyonight", "kanagawa-dragon", "gruvbox", "rose-pine" }

            local is_light = vim.tbl_contains(light_themes, current)
            if is_light then
              set_theme(dark_themes[1]) -- Switch to first dark theme
            else
              set_theme(light_themes[1]) -- Switch to first light theme
            end
          end, {})

          -- Keymaps for theme switching
          vim.keymap.set("n", "<leader>tt", ":ThemeToggle<CR>", { desc = "Toggle light/dark theme" })
          vim.keymap.set("n", "<leader>ta", ":ThemeAuto<CR>", { desc = "Auto-detect theme" })
          vim.keymap.set("n", "<leader>ts", ":ThemeSwitch ", { desc = "Switch theme" })

          -- Set default theme (change this to your preference)
          -- Auto-detect on startup or set manually
          local auto_theme = os.getenv("NVIM_THEME")
          if auto_theme and themes[auto_theme] then
            set_theme(themes[auto_theme])
          else
            -- Try auto-detection or fallback to tokyonight
            pcall(function()
              vim.cmd("ThemeAuto")
            end)
            if not vim.g.colors_name then
              set_theme("tokyonight")
            end
          end
        end,
      })

      return opts
    end,
  },
}
