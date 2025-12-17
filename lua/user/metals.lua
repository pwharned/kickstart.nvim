-- ~/.config/nvim/lua/user/metals.lua

local M = {}
local map = vim.keymap.set

M.config = function()
  local metals = require("metals")
  local metals_config = metals.bare_config()

  -- Replace LunarVim's common LSP helpers with nil or blink.cmp capabilities
  metals_config.on_init = nil -- No common_on_init in kickstart
  metals_config.on_exit = nil -- No common_on_exit in kickstart
  metals_config.capabilities = require("blink.cmp").get_lsp_capabilities() -- Use blink.cmp's capabilities

  metals_config.settings = {
    superMethodLensesEnabled = true,
    showImplicitArguments = true,
    showInferredType = true,
    showImplicitConversionsAndClasses = true,
    excludedPackages = {},
  }

  metals_config.init_options.statusBarProvider = "off"

  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "scala", "sbt", "java" },
    callback = function() metals.initialize_or_attach(metals_config) end,
    group = vim.api.nvim_create_augroup("nvim-metals", { clear = true }),
  })

  metals_config.on_attach = function(client, bufnr)
    -- No lvim_lsp.common_on_attach here, as general LSP mappings are handled by Kickstart's LspAttach
    -- and custom.lsp's additional LspAttach.
    -- Only Metals-specific mappings and DAP setup go here.

    metals.setup_dap() -- Setup DAP for Metals

    local opts = { buffer = bufnr }

    -- Metals-specific LSP mappings (these will override general LSP mappings for Scala/SBT/Java buffers)
    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "K", vim.lsp.buf.hover, opts)
    map("n", "gi", vim.lsp.buf.implementation, opts)
    map("n", "gr", vim.lsp.buf.references, opts)
    map("n", "gds", vim.lsp.buf.document_symbol, opts)
    map("n", "gws", vim.lsp.buf.workspace_symbol, opts)
    map("n", "<leader>cl", vim.lsp.codelens.run, opts)
    map("n", "<leader>sh", vim.lsp.buf.signature_help, opts)
    map("n", "<leader>rn", vim.lsp.buf.rename, opts)
    map("n", "<leader>f", vim.lsp.buf.format, opts)
    map("n", "<leader>ca", vim.lsp.buf.code_action, opts)

    map("n", "<leader>ws", function()
      metals.hover_worksheet()
    end, opts)

    -- Metals-specific diagnostic mappings
    map("n", "<leader>da", vim.diagnostic.setqflist, opts)
    map("n", "<leader>de", function()
      vim.diagnostic.setqflist({ severity = "E" })
    end, opts)
    map("n", "<leader>dw", function()
      vim.diagnostic.setqflist({ severity = "W" })
    end, opts)
    map("n", "<leader>d", vim.diagnostic.setloclist, opts)
    map("n", "[d", function()
      vim.diagnostic.goto_prev({ wrap = false })
    end, opts)
    map("n", "]d", function()
      vim.diagnostic.goto_next({ wrap = false })
    end, opts)

    -- DAP mappings (assuming nvim-dap and nvim-dap-ui are installed)
    map("n", "<leader>dc", function() require("dap").continue() end, opts)
    map("n", "<leader>dr", function() require("dap").repl.toggle() end, opts)
    map("n", "<leader>dK", function() require("dap.ui.widgets").hover() end, opts)
    map("n", "<leader>dt", function() require("dap").toggle_breakpoint() end, opts)
    map("n", "<leader>dso", function() require("dap").step_over() end, opts)
    map("n", "<leader>dsi", function() require("dap").step_into() end, opts)
    map("n", "<leader>dout", function() require("dap").step_out() end, opts)
    map("n", "<leader>dq", function() require("dap").terminate() end, opts)
    map("n", "<leader>dl", function() require("dap").run_last() end, opts)
  end
end

return M

