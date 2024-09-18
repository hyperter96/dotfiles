local LazyVim = require("lazyvim.util")
return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      linters_by_ft = {
        lua = { "selene", "luacheck" },
        cmake = { "cmakelint" },
        -- proto = { "protolint" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        markdown = { "markdownlint-cli2" },
        python = { "pylint" },
      },
      linters = {
        eslint_d = {
          args = {
            "--no-warn-ignored", -- <-- this is the key argument
            "--format",
            "json",
            "--stdin",
            "--stdin-filename",
            function()
              return vim.api.nvim_buf_get_name(0)
            end,
          },
        },
        selene = {
          condition = function(ctx)
            local root = LazyVim.root.get({ normalize = true })
            if root ~= vim.uv.cwd() then
              return false
            end
            return vim.fs.find({ "selene.toml" }, { path = root, upward = true })[1]
          end,
        },
        luacheck = {
          condition = function(ctx)
            local root = LazyVim.root.get({ normalize = true })
            if root ~= vim.uv.cwd() then
              return false
            end
            return vim.fs.find({ ".luacheckrc" }, { path = root, upward = true })[1]
          end,
        },
        ["markdownlint-cli2"] = {
          args = { "--config", "~/.markdownlint-cli2.yaml", "--" },
        },
      },
    },
  },
}
