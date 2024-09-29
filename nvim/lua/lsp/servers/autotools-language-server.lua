return {
  setup = function(on_attach, capabilities)
    require("lspconfig").autotools_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end,
}
