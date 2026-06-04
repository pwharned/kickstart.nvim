local M = {}
M.setup = function()
  local capabilities = require('blink.cmp').get_lsp_capabilities()
  vim.lsp.config('clangd', {
    cmd = { 'clangd', '--header-insertion=never' },
    capabilities = capabilities,
  })
  vim.lsp.enable 'clangd'
  vim.lsp.config('zls', {
    cmd = { 'zls' },
    filetypes = { 'zig', 'zir' },
    root_markers = { 'build.zig', '.git' },
    capabilities = capabilities,
  })
  vim.lsp.enable 'zls'
  vim.lsp.config('ols', {
    cmd = { 'ols' },
    filetypes = { 'odin' },
    root_markers = { 'ols.json', '.git' },
    capabilities = capabilities,
  })
  vim.lsp.enable 'ols'
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('custom-lsp-attach-keymaps', { clear = true }),
    callback = function(event)
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end
      map('gd', vim.lsp.buf.definition, 'Go to Definition')
      map('gi', vim.lsp.buf.implementation, 'Go to Implementation')
      map('gr', vim.lsp.buf.references, 'Go to References')
      map('K', vim.lsp.buf.hover, 'Hover Documentation')
      map('<leader>sh', vim.lsp.buf.signature_help, 'Signature Help')
      map('gds', vim.lsp.buf.document_symbol, 'Document Symbols')
      map('gws', vim.lsp.buf.workspace_symbol, 'Workspace Symbols')
      map('<leader>rn', vim.lsp.buf.rename, 'Rename')
      map('<leader>ca', vim.lsp.buf.code_action, 'Code Action', { 'n', 'x' })
      map('<leader>cl', vim.lsp.codelens.run, 'Run CodeLens')
      map('<leader>da', vim.diagnostic.setqflist, 'All diagnostics')
      map('<leader>de', function()
        vim.diagnostic.setqflist { severity = 'E' }
      end, 'Errors only')
      map('<leader>dw', function()
        vim.diagnostic.setqflist { severity = 'W' }
      end, 'Warnings only')
      map('<leader>d', vim.diagnostic.setloclist, 'Buffer diagnostics')
      map('[d', function()
        vim.diagnostic.goto_prev { wrap = false }
      end, 'Previous diagnostic')
      map(']d', function()
        vim.diagnostic.goto_next { wrap = false }
      end, 'Next diagnostic')
    end,
  })
end
return M
