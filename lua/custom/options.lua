-- ~/.config/nvim/lua/custom/options.lua

-- Clipboard configuration (xsel) - Kickstart sets 'unnamedplus', this adds xsel specific config
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

-- Odin filetype detection
vim.filetype.add {
  extension = {
    odin = 'odin',
  },
}

-- Disable inlay hints globally (Kickstart provides a toggle, but this sets the default to off)
vim.lsp.inlay_hint.enable(false)
vim.treesitter.language.register('gotmpl', 'gotexttmpl')

-- Note:
-- - vim.o.background = "light" is NOT included as Kickstart's colorscheme implies dark.
-- - vim.diagnostic.config is NOT included as Kickstart has a comprehensive one.
--   If you want specific visual tweaks (e.g., prefix='●', spacing=4), you would need to
--   manually adjust Kickstart's diagnostic config in its init.lua.
