return {
  setup = function(on_attach, capabilities)
    require("lspconfig").pylsp.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 200,
      },
      settings = {
        pylsp = {
          plugins = {
            -- formatter options
            black = { enabled = true },
            -- linter
            pylint = { enabled = true, executable = "pylint" },
            -- import sorting
            pyls_isort = { enabled = true },
          },
        },
      },
    })
  end,
}
