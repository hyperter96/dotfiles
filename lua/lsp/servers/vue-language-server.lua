return {
  setup = function(on_attach, capabilities)
    -- Volar is actually set up in lua/lsp/servers/typescript-language-server.lua
    local lspconfig = require("lspconfig")
    lspconfig.volar.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
      init_options = {
        vue = {
          hybridMode = false,
        },
        typescript = {
          tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
        },
      },
      documentFeatures = {
        documentColor = true,
      },
      languageFeatures = {
        semanticTokens = true,
      },
      settings = {
        completeFunctionCalls = true,
        css = {
          validate = true,
          lint = {
            unknownAtRules = "ignore",
          },
        },
        scss = {
          validate = true,
          lint = {
            unknownAtRules = "ignore",
          },
        },
      },
    })
  end,
}
