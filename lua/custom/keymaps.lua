-- ~/.config/nvim/lua/custom/keymaps.lua

local map = vim.keymap.set

-- ============================================================================
-- KEYMAPS - GENERAL
-- ============================================================================

-- Quickfix navigation
map('n', '<leader>e', ':cnext<CR>', { desc = 'Next Quickfix item' })

-- Buffer management (Telescope integration)
-- Note: Kickstart uses <leader><leader> for buffers. This is an additional mapping.
map('n', '<leader>b', '<cmd>Telescope buffers<cr>', { noremap = true, silent = true, desc = 'Find [B]uffers' })
map('n', '<leader>bd', function()
  vim.cmd 'bp'
  vim.cmd 'bd #'
end, { noremap = true, silent = true, desc = 'Delete current [B]uffer' })

-- ============================================================================
-- KEYMAPS - LSP (Global, not LspAttach specific)
-- ============================================================================
-- Note: These are global mappings. Buffer-local LSP mappings are handled in custom.lsp's LspAttach.
-- Conflicts with Kickstart's grr (references) are avoided by not migrating your 'gr' global map.

map('n', '<leader>dh', vim.lsp.buf.hover, { noremap = true, silent = true, desc = 'LSP: [D]ocument [H]over' })

-- Diagnostic float
map('n', '<leader>df', function()
  vim.diagnostic.open_float(nil, { scope = 'line', border = 'rounded', focusable = true })
end, { noremap = true, silent = true, desc = 'LSP: [D]iagnostic [F]loat' })

-- Custom go-to-definition with float preview
map('n', 'pd', function()
  local params = vim.lsp.util.make_position_params()
  vim.lsp.buf_request(0, 'textDocument/definition', params, function(err, result, ctx, config)
    if err or not result or vim.tbl_isempty(result) then
      return
    end
    local uri = result[1].uri or result[1].targetUri
    local range = result[1].range or result[1].targetSelectionRange or result[1]
    local bufnr = vim.uri_to_bufnr(uri)
    vim.fn.bufload(bufnr)
    local lines = vim.api.nvim_buf_get_lines(bufnr, range.start.line, range['end'].line + 1, false)
    local opts = { border = 'rounded', title = 'definition' }
    vim.lsp.util.open_floating_preview(lines, 'text', opts)
  end)
end, { silent = true, desc = 'LSP: [P]review [D]efinition' })

-- ============================================================================
-- DEV/DEBUG UTILITIES
-- ============================================================================
-- Reload custom LSP module (if you have one, e.g., mylsp.def)
map('n', '<leader>rc', function()
  package.loaded['mylsp.def'] = nil
  -- Ensure 'mylsp.def' exists or remove this mapping if not used
  pcall(require, 'mylsp.def')
  vim.notify 'reloaded mylsp.def'
end, { desc = 'Reload Custom LSP Module' })

-- DAP UI close
map('n', '<leader>dx', function()
  require('dapui').close()
end, { noremap = false, silent = true, desc = 'DAP: Close UI' })

-- Note:
-- - Your Telescope keymaps (<leader>ff, <leader>fg, <leader>fb, <leader>fh) are NOT included
--   as they conflict with Kickstart's existing Telescope mappings.
vim.keymap.set('n', '<leader>gt', ':GoTest<CR>', { desc = 'Go Test' })
vim.keymap.set('n', '<leader>gr', ':GoRun<CR>', { desc = 'Go Run' })
vim.keymap.set('n', '<leader>gf', ':GoFmt<CR>', { desc = 'Go Format' })
