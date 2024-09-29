return {
  setup = function(on_attach, capabilities)
    require("lspconfig").ltex.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end,
}
