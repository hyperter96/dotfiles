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
        javascriptreact = { "dprint" },
        typescript = { "prettierd" },
        typescriptreact = { "dprint" },
        vue = { "prettierd" },
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
        dprint = {
          condition = function(_, ctx)
            return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
          end,
        },
      },
    },
  },
}
