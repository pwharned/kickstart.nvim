vim.g.clipboard = {
  name = 'xsel',
  copy = {
    ['+'] = 'xsel --input --clipboard',
    ['*'] = 'xsel --input --primary',
  },
  paste = {
    ['+'] = 'xsel --output --clipboard',
    ['*'] = 'xsel --output --primary',
  },
}
vim.filetype.add {
  extension = { odin = 'odin' },
}
vim.lsp.inlay_hint.enable(false)
