local util = require("lspconfig.util")

return {
  setup = function(on_attach, _)
    require("lspconfig").clangd.setup({
      capabilities = {
        offsetEncoding = { "utf-16" },
      },
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        vim.keymap.set(
          "n",
          "<leader>Ch",
          "<cmd>ClangdSwitchSourceHeader<cr>",
          { desc = "Switch Source/Header (C/C++)" }
        )
        vim.keymap.set("n", "<leader>Cr", "<cmd>CMakeRun<cr>", { desc = "Run Selected Launchable Target" })
        vim.keymap.set("n", "<leader>Cl", "<cmd>CMakeLauchArgs<cr>", { desc = "CMakeRun with Additional Argument" })
        vim.keymap.set("n", "<leader>Cc", "<cmd>CMakeClean<cr>", { desc = "Clean All Targets & Deps" })
        vim.keymap.set("n", "<leader>Cq", "<cmd>CMakeClose<cr>", { desc = "Close CMake Executor/Runner Window" })
        vim.keymap.set("n", "<leader>Cb", "<cmd>CMakeBuild<cr>", { desc = "Compile Targets with Pre-build System" })
        vim.keymap.set("n", "<leader>Cg", "<cmd>CMakeGenerate<cr>", { desc = "Generate Native Build System" })
        vim.keymap.set("n", "<leader>Cd", "<cmd>CMakeDebug<cr>", { desc = "Debug Selected Launchable Target" })
      end,
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
