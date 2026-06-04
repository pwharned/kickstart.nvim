local map = vim.keymap.set
local metals = require 'metals'
local metals_config = metals.bare_config()
metals_config.capabilities = require('blink.cmp').get_lsp_capabilities()
metals_config.settings = {
  superMethodLensesEnabled = true,
  showImplicitArguments = true,
  showInferredType = true,
  showImplicitConversionsAndClasses = true,
  excludedPackages = {},
}
metals_config.init_options.statusBarProvider = 'off'
metals_config.on_attach = function(client, bufnr)
  metals.setup_dap()
  local opts = { buffer = bufnr }
  map('n', 'gd', vim.lsp.buf.definition, opts)
  map('n', 'K', vim.lsp.buf.hover, opts)
  map('n', 'gi', vim.lsp.buf.implementation, opts)
  map('n', 'gr', vim.lsp.buf.references, opts)
  map('n', 'gds', vim.lsp.buf.document_symbol, opts)
  map('n', 'gws', vim.lsp.buf.workspace_symbol, opts)
  map('n', '<leader>cl', vim.lsp.codelens.run, opts)
  map('n', '<leader>sh', vim.lsp.buf.signature_help, opts)
  map('n', '<leader>rn', vim.lsp.buf.rename, opts)
  map('n', '<leader>f', vim.lsp.buf.format, opts)
  map('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  map('n', '<leader>ws', metals.hover_worksheet, opts)
  map('n', '<leader>da', vim.diagnostic.setqflist, opts)
  map('n', '<leader>de', function()
    vim.diagnostic.setqflist { severity = 'E' }
  end, opts)
  map('n', '<leader>dw', function()
    vim.diagnostic.setqflist { severity = 'W' }
  end, opts)
  map('n', '<leader>d', vim.diagnostic.setloclist, opts)
  map('n', '[d', function()
    vim.diagnostic.goto_prev { wrap = false }
  end, opts)
  map('n', ']d', function()
    vim.diagnostic.goto_next { wrap = false }
  end, opts)
  map('n', '<leader>dc', function()
    require('dap').continue()
  end, opts)
  map('n', '<leader>dr', function()
    require('dap').repl.toggle()
  end, opts)
  map('n', '<leader>dK', function()
    require('dap.ui.widgets').hover()
  end, opts)
  map('n', '<leader>dt', function()
    require('dap').toggle_breakpoint()
  end, opts)
  map('n', '<leader>dso', function()
    require('dap').step_over()
  end, opts)
  map('n', '<leader>dsi', function()
    require('dap').step_into()
  end, opts)
  map('n', '<leader>dout', function()
    require('dap').step_out()
  end, opts)
  map('n', '<leader>dq', function()
    require('dap').terminate()
  end, opts)
  map('n', '<leader>dl', function()
    require('dap').run_last()
  end, opts)
end
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'scala', 'sbt', 'java' },
  callback = function()
    metals.initialize_or_attach(metals_config)
  end,
  group = vim.api.nvim_create_augroup('nvim-metals', { clear = true }),
})
