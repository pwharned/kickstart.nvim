local M = {}
M.merge_config = function()
  require('nvim-treesitter').setup {
    ensure_installed = {
      'bash',
      'c',
      'diff',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
      'python',
      'javascript',
      'zig',
      'go',
      'gomod',
      'gotmpl',
    },
  }
end
return M
