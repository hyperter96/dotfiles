return {
  setup = function(on_attach, capabilities)
    require("lspconfig").jinja_lsp.setup({
      capabilities = capabilities,
      name = "jinja-lsp",
      cmd = { "jinja-lsp" },
      filetypes = { "jinja", "rust", "tera", "tera.html" },
      root_dir = function(fname)
        return require("lspconfig").util.find_git_ancestor(fname)
      end,
      settings = {
        jinja = {
          -- 根据需要配置模板路径
          templates = {
            "templates", -- 模板目录
          },
        },
      },
    })
  end,
}
