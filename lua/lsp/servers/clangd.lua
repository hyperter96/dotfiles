local util = require("lspconfig.util")

return {
  setup = function(on_attach, _)
    require("lspconfig").clangd.setup({
      capabilities = {
        offsetEncoding = { "utf-16" },
      },
      on_attach = on_attach,
      root_dir = function(fname)
        return util.root_pattern(
          "Makefile",
          "configure.ac",
          "configure.in",
          "config.h.in",
          "meson.build",
          "meson_options.txt",
          "build.ninja"
        )(fname) or util.root_pattern("compile_commands.json", "compile_flags.txt")(fname) or util.find_git_ancestor(
          fname
        )
      end,
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=llvm",
      },
      flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
      init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
      },
    })
  end,
}
