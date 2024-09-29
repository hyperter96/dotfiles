return {
  setup = function(on_attach, capabilities)
    local _snippet_capabilities = vim.lsp.protocol.make_client_capabilities()
    ---@diagnostic disable-next-line: inject-field
    _snippet_capabilities.textDocument.completion.completionItem.snippetSupport = true
    local snippet_capabilities = vim.tbl_extend("keep", capabilities, _snippet_capabilities)
    require("lspconfig").jsonls.setup({
      on_attach = on_attach,
      capabilities = snippet_capabilities,
      on_new_config = function(new_config)
        new_config.settings.json.schemas = new_config.settings.json.schemas or {}
        vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
      end,
      settings = {
        json = {
          format = {
            enable = true,
          },
          schemas = require("schemastore").json.schemas({
            select = {
              "package.json",
              ".eslintrc",
              "tsconfig.json",
            },
          }),
          validate = { enable = true },
        },
      },
    })
  end,
}
