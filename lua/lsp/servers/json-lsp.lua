return {
  setup = function(on_attach, capabilities)
    require("lspconfig").jsonls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end,
}
