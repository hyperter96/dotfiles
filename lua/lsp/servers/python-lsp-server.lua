return {
  setup = function(on_attach, capabilities)
    require("lspconfig").pylsp.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        pylsp = {
          plugins = {
            -- formatter options
            black = { enabled = true },
            pylint = { enabled = true, executable = "pylint" },
            pyls_isort = { enabled = true },
          },
        },
      },
    })
  end,
}
