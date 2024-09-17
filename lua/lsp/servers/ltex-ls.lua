return {
  setup = function(on_attach, capabilities)
    require("lspconfig").ltex_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end,
}
