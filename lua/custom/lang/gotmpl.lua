vim.filetype.add {
  extension = {
    gotmpl = 'gotmpl',
    gohtmltmpl = 'gohtmltmpl',
  },
}
vim.treesitter.language.register('gotmpl', 'gotexttmpl')
require('conform').formatters_by_ft.gohtmltmpl = { 'prettier' }
