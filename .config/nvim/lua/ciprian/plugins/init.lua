-- Set file format options
vim.opt.fileformat = "unix"
vim.opt.fileformats = "unix,dos"

-- Auto-clean line endings on paste
vim.api.nvim_create_autocmd("TextChanged", {
  pattern = "*",
  callback = function()
    -- Remove carriage returns after text changes (like paste)
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[silent! %s/\r//g]])
    vim.api.nvim_win_set_cursor(0, pos)
  end,
})

-- Alternative: Clean on BufWritePre (before saving)
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[silent! %s/\r$//g]])
    vim.api.nvim_win_set_cursor(0, pos)
  end,
})

-- Key mapping to manually clean line endings
vim.keymap.set("n", "<leader>cl", function()
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.cmd([[%s/\r//g]])
  vim.api.nvim_win_set_cursor(0, pos)
  print("Cleaned line endings")
end, { desc = "Clean line endings" })

-- Alternative: Set paste options
vim.opt.paste = false -- Ensure paste mode is off
vim.opt.clipboard = "unnamedplus" -- Use system clipboard

return {
  "nvim-lua/plenary.nvim", -- lua functions that many plugins use
  "christoomey/vim-tmux-navigator", -- tmux & split window navigation
}
