return {
  {
    "kevinhwang91/nvim-ufo",
    optional = false,
    dependencies = "kevinhwang91/promise-async",
    init = function()
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    config = function()
      require("ufo").setup()

      -- Using ufo provider need remap `zR` and `zM`.
      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

      local lsp_zero = require("lsp-zero")

      local lsp_capabilities = vim.tbl_deep_extend("force", require("cmp_nvim_lsp").default_capabilities(), {
        textDocument = {
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          },
        },
      })

      lsp_zero.extend_lspconfig({
        capabilities = lsp_capabilities,
      })
    end,
  },
  { "kevinhwang91/promise-async" },
}
