return {
  {
    "williamboman/mason.nvim",
    optional = false,
    opts = {
      ensure_installed = {
        "black",
        "codelldb",
        "clangd",
        "clang-format",
        "cmakelang",
        "cmakelint",
        "eslint_d",
        "goimports",
        "gofumpt",
        "gopls",
        "pyright",
        "debugpy",
        "gomodifytags",
        "impl",
        "isort",
        "delve",
        "markdownlint-cli2",
        "markdown-toc",
        "zls",
        "texlab",
        "js-debug-adapter",
        "eslint-lsp",
        "json-lsp",
        "prettier",
        "yaml-language-server",
        "typescript-language-server",
        "tailwindcss-language-server",
        "ansible-lint",
        "ltex-ls",
        "hadolint",
        "vue-language-server",
        "taplo",
        "jdtls",
        "java-debug-adapter",
        "java-test",
        "google-java-format",
        "haskell-language-server",
        "haskell-debug-adapter",
      },
    },
    config = function()
      -- import mason
      local mason = require("mason")

      -- enable mason and configure icons
      mason.setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },
}
