return {
  setup = function(on_attach, capabilities)
    require("lspconfig").protolint.setup({
      cmd = { "protolint", "lint", "." },
      filetypes = { "proto" },
      root_dir = require("lspconfig").util.root_pattern(
        ".git",
        ".protolint.json",
        ".protolint.yaml",
        ".protolintrc.yml"
      ),
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end,
}
