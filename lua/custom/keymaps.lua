local map = vim.keymap.set
map('n', '<leader>e', function()
  vim.diagnostic.open_float()
end, { desc = 'Show diagnostic popup' })
-- in custom/keymaps.lua
map({ 'n', 'i', 'v' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save file' })
map('n', '<leader>cn', ':cnext<CR>', { desc = 'Next quickfix item' })
map('n', 'pd', '<cmd>Glance definitions<CR>', { desc = 'Preview definition' })
map('n', 'pi', '<cmd>Glance implementations<CR>', { desc = 'Preview implementations' })
map('n', '<leader>b', '<cmd>Telescope buffers<cr>', { desc = 'Find buffers' })
map('n', '<leader>bd', function()
  vim.cmd 'bp'
  vim.cmd 'bd #'
end, { desc = 'Delete current buffer' })
map('n', '<leader>dh', vim.lsp.buf.hover, { desc = 'LSP hover' })
map('n', '<leader>df', function()
  vim.diagnostic.open_float(nil, { scope = 'line', border = 'rounded', focusable = true })
end, { desc = 'Diagnostic float' })
map('n', '<leader>dx', function()
  require('dapui').close()
end, { desc = 'DAP: Close UI' })

--vim.api.nvim_create_autocmd('CursorHold', {
-- callback = function()
--   vim.diagnostic.open_float(nil, { focus = false })
--end,
--})
-- in custom/keymaps.lua
vim.api.nvim_create_autocmd('FocusLost', {
  callback = function()
    vim.cmd 'silent! wa'
  end,
})
