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
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    cmd = {
      'CodeCompanion',
      'CodeCompanionChat',
      'CodeCompanionActions',
      'CodeCompanionToggle',
    },
    keys = {
      { '<leader>ac', desc = 'AI: Toggle chat' },
      { '<leader>af', desc = 'AI: Chat with current file' },
      { '<leader>ai', desc = 'AI: Actions picker' },
      { '<leader>ae', desc = 'AI: Explain selection', mode = 'v' },
      { '<leader>ar', desc = 'AI: Review selection', mode = 'v' },
      { '<leader>as', desc = 'AI: Summarise selection', mode = 'v' },
    },
  },
}
