-- ~/.config/nvim/lua/custom/lsp.lua

local M = {}

M.setup = function()
  local lspconfig = require('lspconfig')
  local mason_tool_installer = require('mason-tool-installer')
  local mason_lspconfig = require('mason-lspconfig')
  local capabilities = require('blink.cmp').get_lsp_capabilities()

  -- Define your additional LSP servers
  local custom_servers = {
    gopls = {
      cmd = { "gopls" },
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
        },
      },
    },
    clangd = {
      cmd = { "clangd", "--header-insertion=never" },
    },
    zls = {
      cmd = { "zls" },
      filetypes = { "zig", "zir" },
      root_dir = lspconfig.util.root_pattern("build.zig", ".git") or vim.loop.cwd,
      single_file_support = true,
    },
    ols = {
      cmd = { "ols" },
      filetypes = { "odin" },
      root_dir = lspconfig.util.root_pattern("ols.json", ".git"),
    },
  }

  -- Ensure these additional servers are installed via Mason
  -- Calling mason_tool_installer.setup again will add to the existing list.
  mason_tool_installer.setup {
    ensure_installed = vim.tbl_keys(custom_servers),
  }

  -- Setup Mason LSPConfig handlers for custom servers
  -- This will add handlers for your custom servers without affecting Kickstart's existing ones.
  mason_lspconfig.setup {
    ensure_installed = {}, -- Handled by mason-tool-installer
    automatic_installation = false,
    handlers = {
      function(server_name)
        if custom_servers[server_name] then
          local server_opts = custom_servers[server_name]
          server_opts.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server_opts.capabilities or {})
          lspconfig[server_name].setup(server_opts)
        end
      end,
    },
  }

  -- Add your LunarVim LspAttach keymaps to Kickstart's LspAttach autocmd.
  -- We create a *new* autocmd group to avoid overwriting Kickstart's.
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('custom-lsp-attach-keymaps', { clear = true }),
    callback = function(event)
      local opts = { buffer = event.buf }
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      -- Your LunarVim LspAttach keymaps
      map("gd", vim.lsp.buf.definition, "Go to Definition")
      map("K", vim.lsp.buf.hover, "Hover Documentation")

      -- Format on 'o' key (from LunarVim)
      map('o', vim.lsp.buf.format, "Format", { mode = { 'n', 'x' } })
    end,
  })
end

return M

