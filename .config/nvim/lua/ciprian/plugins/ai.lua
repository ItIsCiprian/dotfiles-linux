return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      adapters = {
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            env = {
              api_key = function()
                return vim.fn.trim(vim.fn.system("op read op://Personal/openai-api-key/credential"))
              end,
            },
          })
        end,
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            env = {
              api_key = function()
                return vim.fn.trim(vim.fn.system("op read op://Personal/gemini-api-key/credential"))
              end,
            },
          })
        end,
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = function()
                return vim.fn.trim(vim.fn.system("op read op://Personal/claude-api-key/credential"))
              end,
            },
          })
        end,
      },
      strategies = {
        chat = {
          adapter = "gemini", -- Default adapter for chat
        },
        inline = {
          adapter = "gemini", -- Default adapter for inline suggestions
        },
        agent = {
          adapter = "gemini", -- Default adapter for agentic workflows
        },
      },
    })
  end,
}
