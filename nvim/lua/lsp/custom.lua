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

lspconfig.gopls.setup({
  on_attach = function(client, bufnr)
    -- Disable clangd for proto file types
    local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
    if filetype == "gotmpl" or filetype == "helm" then
      client.stop()
    end
  end,
})
