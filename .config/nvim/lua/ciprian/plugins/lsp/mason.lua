return {
  "williamboman/mason.nvim",
  build = ":MasonUpdate",
  lazy = true,
  cmd = "Mason", -- Lazy load with the Mason command
  config = function()
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })
  end,
}
