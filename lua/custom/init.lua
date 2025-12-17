-- ~/.config/nvim/lua/custom/init.lua

-- This module serves as the entry point for all your custom configurations.
-- It loads other custom modules and integrates them with the Kickstart setup.

-- Load general options and global settings
require('custom.options')


-- Configure existing Kickstart plugins or new ones
-- Note: These setup calls will merge with or add to Kickstart's existing configurations.

-- Merge Treesitter ensure_installed languages
require('custom.treesitter').merge_config()

-- Merge Telescope custom settings
require('custom.telescope').merge_config()

-- Setup NvimTree (new plugin)
require('custom.nvimtree').setup()

-- Setup ToggleTerm and integrate with which-key (new plugin)
require('custom.terminal').setup()

-- Load custom keymaps
require('custom.keymaps')

-- Load and integrate LSP configurations
require('custom.lsp').setup()

-- Load LaTeX and Zathura utilities
require('custom.latex')

-- Load Metals-specific configuration (user.metals)
-- This needs to be called after lspconfig is set up.
require('user.metals').config()

-- You can add more custom modules here as your configuration grows.

