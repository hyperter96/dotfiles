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
        expose_as_code_action = "all",
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeCompletionsForModuleExports = true,
          quotePreference = "auto",
          allowImportingTsExtensions = true,
        },
        tsserver_format_options = {
          allowIncompleteCompletions = false,
          allowRenameOfImportPath = true,
        },
        root_dir = utils.root_pattern_exclude({
          root = { "package.json", "tsconfig.json" },
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
