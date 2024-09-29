-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("plugins.dap")
require("lsp.copilot")
require("git-helpers")
-- require("avante_lib").load()

-- Setup Telescope
require("telescope").setup({
  pickers = {
    colorscheme = {
      enable_preview = true,
    },
  },
})

-- Load highlight configurations
require("highlight")

-- Setup LSP configurations
local lspconfig = require("lspconfig")

-- Custom configuration for clangd
lspconfig.clangd.setup({
  on_attach = function(client, bufnr)
    -- Disable clangd for proto file types
    local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
    if filetype == "proto" then
      client.stop()
    end
  end,
})
