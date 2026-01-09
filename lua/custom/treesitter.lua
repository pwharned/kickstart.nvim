-- ~/.config/nvim/lua/custom/treesitter.lua

local M = {}

M.merge_config = function()
  local ts = require 'nvim-treesitter'

  -- These are the parsers that were in Kickstart's original 'opts.ensure_installed'
  local all_parsers = {
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
    'go-template',
    'gotmpl',
    'html',
  }

  -- Install all required parsers.
  -- This will run `TSInstall` for any missing parsers.
  -- The `auto_install = true` from Kickstart's old config is implicitly handled
  -- by calling `ts.install` for each parser.
  for _, parser in ipairs(all_parsers) do
    pcall(ts.install, parser)
  end

  -- Kickstart's init.lua already has an autocmd like this:
  -- vim.api.nvim_create_autocmd('FileType', {
  --   callback = function()
  --     pcall(vim.treesitter.start)
  --   end,
  -- })
  -- This autocmd is sufficient to enable Treesitter highlighting and indent
  -- for buffers once the parsers are installed. We do NOT need to add another one here.

  -- If you had specific Treesitter *modules* to configure (e.g., textobjects, context),
  -- you would configure them here using their direct `require().setup()` calls.
  -- For example:
  -- require('nvim-treesitter.textobjects').setup { ... }
  -- require('nvim-treesitter.context').setup { ... }
end

return M
