require 'custom.options'
require('custom.telescope').merge_config()
require('custom.treesitter').merge_config()
require('custom.nvimtree').setup()
require('custom.terminal').setup()
require 'custom.keymaps'
require('custom.lsp').setup()
require 'custom.lang.go'
require 'custom.lang.gotmpl'
require 'custom.lang.scala'
require 'custom.lang.latex'
