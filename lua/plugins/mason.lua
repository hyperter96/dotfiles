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
        "protolint",
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

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      -- import mason
      local mason = require("mason")
      local lspconfig = require("lspconfig")
      local configs = require("lspconfig.configs")

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

      if not configs.protolint then
        configs.protolint = {
          default_config = {
            cmd = { "protolint", "lint", "." },
            filetypes = { "proto" },
            root_dir = lspconfig.util.root_pattern(".git", ".protolint.json", ".protolint.yaml", ".protolintrc.yml"),
          },
        }
      end

      if not configs.protobuf_language_server then
        configs.protobuf_language_server = {
          default_config = {
            cmd = { '/root/go/bin/protobuf-language-server' },
            filetypes = { 'proto', 'cpp' },
            root_fir = lspconfig.util.root_pattern('.git'),
            single_file_support = true,
            settings = {
              ["additional-proto-dirs"] = {
                  -- path to additional protobuf directories
                  -- "vendor",
                  "third_party",
              },
            },
          },
        }
      end
      -- lspconfig.protolint.setup({})
    end,
  },
}
