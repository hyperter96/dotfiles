return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    optional = false,
    opts = {
      formatters_by_ft = {
        ["python"] = { "isort", "black" },
        lua = { "stylua" },
        javascript = { "prettierd", "prettier" },
        javascriptreact = { "dprint" },
        typescript = { "prettierd", "prettier" },
        typescriptreact = { "dprint" },
        go = { "gofumpt" },
        less = { "prettierd", "prettier" },
        toml = { "taplo" },
        java = { "google-java-format" },
        html = { "prettierd", "prettier" },
        json = { "prettierd", "prettier" },
        jsonc = { "prettierd", "prettier" },
        yaml = { "prettierd", "prettier" },
        markdown = { "prettierd", "prettier" },
        ["c"] = { "clang_format" },
        ["cpp"] = { "clang_format" },
        ["c++"] = { "clang_format" },
        rust = { "rustfmt" },
        xml = { "xmllint" },
      },
      formatters = {
        dprint = {
          condition = function(_, ctx)
            return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
          end,
        },
      },
    },
  },
}
