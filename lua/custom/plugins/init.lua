-- ~/.config/nvim/lua/custom/plugins_list.lua

-- This module returns a table of plugin specifications to be added to lazy.nvim's setup.
-- These are plugins from your LunarVim config that are not in Kickstart.

return {
  { "nvim-neotest/nvim-nio" }, -- Dependency for nvim-metals

  {
    "scalameta/nvim-metals",
    -- The actual config function is in lua/user/metals.lua, called from custom/init.lua
    -- fidget.nvim is already a dependency of nvim-lspconfig in kickstart, so it's handled.
  },

  {
    "lervag/vimtex",
    lazy = false, -- We don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here
      vim.g.vimtex_view_method = "zathura"
    end
  },

  -- solarized.nvim is NOT included as it conflicts with Kickstart's tokyonight.nvim.
  -- If you want solarized, you must manually change the colorscheme plugin in Kickstart's init.lua.

  {
    "Tetralux/odin.vim"
  },

  {
    "nvim-tree/nvim-tree.lua",
    -- NvimTree configuration will be handled in custom.nvimtree
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    -- ToggleTerm configuration will be handled in custom.terminal
  },

  -- DAP plugins (implied by your DAP keymaps and metals.setup_dap())
  { "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
}

