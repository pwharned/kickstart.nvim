-- ~/.config/nvim/lua/custom/terminal.lua

local M = {}
local map = vim.keymap.set

M.setup = function()
  require('toggleterm').setup {
    -- Default settings, customize as needed
    size = 20,
    open_mapping = [[<C-t>]], -- Your LunarVim mapping
    hide_numbers = true,
    direction = 'float',
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 1,
    start_in_insert = true,
    insert_mappings = false,
    persist_size = true,
    close_on_exit = true,
    shell = vim.o.shell,
    -- Add any other ToggleTerm options here
  }

  -- Your LunarVim terminal keymaps via which-key
  -- This adds to Kickstart's existing which-key mappings.
  require('which-key').add {
    { '<leader>tf', '<cmd>ToggleTerm<cr>', desc = 'Floating terminal' },
    { '<leader>tv', '<cmd>2ToggleTerm size=30 direction=vertical<cr>', desc = 'Vertical terminal' },
    { '<leader>th', '<cmd>2ToggleTerm size=30 direction=horizontal<cr>', desc = 'Horizontal terminal' },
    { '<leader>t', group = '+Terminal' },
  }
end

return M
