local util = require("lspconfig.util")

return {
  setup = function(on_attach, _)
    require("lspconfig").thriftls.setup({
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)
      end,
      cmd = { "thriftls" },
      filetypes = { "thrift" },
      root_dir = util.root_pattern(".thrift"),
      single_file_support = true,
    })
  end,
}
