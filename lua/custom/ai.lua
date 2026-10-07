local M = {}
M.setup = function()
  require('codecompanion').setup {
    log_level = 'DEBUG',

    -- Point every strategy at our local Ollama model.
    adapters = {
      ollama = function()
        return require('codecompanion.adapters').extend('ollama', {
          schema = {
            model = {
              default = 'qwen-coder3b', -- the permanent model we created
            },
            num_ctx = {
              default = 32768, -- full context window
            },
          },
        })
      end,
    },
    strategies = {
      chat = { adapter = 'ollama' },
      inline = { adapter = 'ollama' },
      agent = { adapter = 'ollama' },
    },
    display = {
      chat = {
        window = {
          layout = 'vertical', -- panel on the right
          width = 0.35, -- 35% of total window width
        },
      },
    },
  }
  -- Register the which-key group label.
  require('which-key').add {
    { '<leader>a', group = '+AI' },
  }
  local map = vim.keymap.set
  -- Toggle the chat panel from anywhere.
  map({ 'n', 'v' }, '<leader>ac', '<cmd>CodeCompanionChat Toggle<cr>', {
    desc = 'AI: Toggle chat',
  })
  -- Open chat with the current file pre-loaded as context.
  -- #buffer is codecompanion's variable for the current buffer.
  -- The chat opens, the file is attached, and you can start asking
  -- questions about it immediately.
  map('n', '<leader>af', function()
    local filename = vim.fn.expand '%:t'
    -- Open chat and attach current buffer as sticky context.
    vim.cmd 'CodeCompanionChat'
    -- Small delay so the chat buffer is ready before we send the message.
    vim.defer_fn(function()
      -- Feed #buffer into the chat input to attach the file.
      -- The model will receive the full file contents as context.
      local chat = require('codecompanion').buf_get_chat(0)
      if chat then
        chat:append_to_buf { role = 'user', content = '#buffer' }
        vim.notify('Added ' .. filename .. ' to chat context', vim.log.levels.INFO)
      end
    end, 100)
  end, { desc = 'AI: Chat with current file' })
  -- Open the full built-in actions picker.
  -- This includes explain, fix, generate tests, and more.
  map({ 'n', 'v' }, '<leader>ai', '<cmd>CodeCompanionActions<cr>', {
    desc = 'AI: Actions picker',
  })
  -- Visual mode inline actions.
  -- These send the selected text directly to the chat panel with a
  -- specific instruction prepended.
  map('v', '<leader>ae', function()
    vim.cmd 'CodeCompanionChat Add'
    vim.defer_fn(function()
      local chat = require('codecompanion').buf_get_chat(0)
      if chat then
        chat:append_to_buf {
          role = 'user',
          content = 'Explain what this code does clearly and concisely:',
        }
      end
    end, 100)
  end, { desc = 'AI: Explain selection' })
  map('v', '<leader>ar', '<cmd>CodeCompanionChat Add<cr>', {
    desc = 'AI: Add selection and review',
  })
  map('v', '<leader>as', function()
    vim.cmd 'CodeCompanionChat Add'
    vim.defer_fn(function()
      local chat = require('codecompanion').buf_get_chat(0)
      if chat then
        chat:append_to_buf {
          role = 'user',
          content = 'Summarise what this code does in plain English:',
        }
      end
    end, 100)
  end, { desc = 'AI: Summarise selection' })
end
return M
