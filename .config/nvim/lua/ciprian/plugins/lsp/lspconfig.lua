return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Set up diagnostic signs
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "",
          [vim.diagnostic.severity.WARN]  = "",
          [vim.diagnostic.severity.HINT]  = "󰠠",
          [vim.diagnostic.severity.INFO]  = "",
        },
      },
    })

    -- Common on_attach function for setting up keymaps and LSP handlers
    local on_attach = function(client, bufnr)
      local opts = { buffer = bufnr, silent = true }
      local keymap = vim.keymap

      -- Keymaps
      keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      keymap.set("n", "<leader>gd", "<cmd>Telescope lsp_definitions<CR>", opts)
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
      keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
      keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
      keymap.set("n", "K", vim.lsp.buf.hover, opts)
      keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

      -- LSP handlers
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.handlers.hover
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.handlers.signature_help
    end

    mason_lspconfig.setup({
      automatic_installation = true,
      handlers = {
        -- Default setup for all servers
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
          })
        end,

        -- Lua LS with settings
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
                completion = {
                  callSnippet = "Replace",
                },
              },
            },
          })
        end,

        -- TS Server
        ["tsserver"] = function()
          lspconfig.tsserver.setup({
            capabilities = capabilities,
            on_attach = on_attach,
          })
        end,
      },
    })
  end,
}

