-- ~/.config/nvim/lua/custom/nvimtree.lua

local M = {}
local map = vim.keymap.set

M.setup = function()
  require("nvim-tree").setup {
    view = {
      side = "left",
      width = 30,
    },
    filters = {
      dotfiles = false, -- show hidden files (NERDTreeShowHidden = 1)
      custom = { "node_modules" }, -- hide node_modules
    },
    update_focused_file = {
      enable = true,
      update_root = false,
      ignore_list = {},
    },
    git = {
      enable = true,
      ignore = false,
    },
    renderer = {
      group_empty = true,
      highlight_git = true,
      highlight_opened_files = "all",
      indent_markers = {
        enable = true,
      },
    },
    -- Add any other nvim-tree options here
  }

  -- Keymaps (NERDTree replacements from LunarVim)
  map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
  map("n", "<C-f>", "<cmd>NvimTreeFindFile<CR>", { desc = "Reveal file in NvimTree" })
end

return M

