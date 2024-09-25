local utils = require("utils")
return {
  setup = function(on_attach, capabilities)
    require("typescript-tools").setup({
      filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
      },
      settings = {
        capabilities = capabilities,
        root_dir = utils.root_pattern_exclude({
          root = { "package.json" },
          exclude = { "deno.json", "deno.jsonc" },
        }),
        single_file_support = false,
        tsserver_plugins = {
          "@vue/typescript-plugin",
        },
      },
    })
  end,
}
