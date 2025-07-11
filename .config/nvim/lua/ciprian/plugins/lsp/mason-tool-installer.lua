return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  lazy = true,
  event = "VeryLazy",
  config = function()
    require("mason-tool-installer").setup({
      ensure_installed = {
        "prettier",
        "stylua",
        "eslint",
        "pylint",
        "typescript-language-server",
      },
    })
  end,
}
