return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    optional = false,
    opts = {
      formatters_by_ft = {
        python = { "isort", "black" },
        lua = { "stylua" },
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        vue = { "eslint_d" },
        go = { "goimports", "gofumpt" },
        less = { "prettierd" },
        toml = { "taplo" },
        java = { "google-java-format" },
        html = { "prettierd" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        yaml = { "prettierd" },
        markdown = { "prettierd" },
        ["c"] = { "clang_format" },
        ["cpp"] = { "clang_format" },
        ["c++"] = { "clang_format" },
        rust = { "rustfmt" },
        xml = { "xmllint" },
      },
      formatters = {
        project_eslint = {
          cwd = require("conform.util").root_file(".git"),
          command = "pnpm",
          -- Doesn't work because ESlint requires that non-fixable errors be reported
          -- https://github.com/eslint/eslint/issues/5393
          -- args = { "run", "lint:fix", "--", "--stdin", "$FILENAME" },
          args = { "run", "lint" },
          stdin = false,
          condition = function(self, ctx)
            return vim.fs.root(0, ".git") ~= "healthmatters"
          end,
        },
      },
    },
  },
}
