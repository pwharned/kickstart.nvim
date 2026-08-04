return {

  {
    'dnlhc/glance.nvim',
    config = function()
      require('glance').setup()
    end,
  },
  { 'scalameta/nvim-metals' },
  { 'nvim-neotest/nvim-nio' },
  { 'mfussenegger/nvim-dap' },
  { 'rcarriga/nvim-dap-ui', dependencies = { 'mfussenegger/nvim-dap' } },
  {
    'lervag/vimtex',
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = 'zathura'
    end,
  },
  { 'Tetralux/odin.vim' },
  { 'nvim-tree/nvim-tree.lua' },
  { 'akinsho/toggleterm.nvim', version = '*' },
}
