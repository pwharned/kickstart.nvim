-- ~/.config/nvim/lua/custom/telescope.lua

local M = {}
local actions = require("telescope.actions")

M.merge_config = function()
  -- Merge your specific Telescope settings with Kickstart's existing setup.
  -- This will update the defaults and add the buffers picker without overwriting everything.
  require("telescope").setup {
    defaults = {
      sort_mru = true,
      show_all_buffers = true,
      mappings = {
        i = { ["<esc>"] = actions.close }, -- Your custom mapping
        -- Kickstart's default mappings are still active unless explicitly overridden here.
      },
    },
    pickers = {
      buffers = {
        sort_mru = true,
        previewer = false,
      }
    },
    -- Kickstart's extensions and other settings remain untouched.
  }
end

return M

