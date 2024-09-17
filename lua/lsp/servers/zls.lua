local util = require("lspconfig.util")

return {
  setup = function(_, _)
    require("lspconfig").zls.setup({
      on_attach = function(client, bufnr)
        -- zig keymap
        vim.keymap.set("n", "<leader>zr", "<cmd>Zig run<cr>", { desc = "Run Zig Current File" })
        vim.keymap.set("n", "<leader>zb", "<cmd>Zig build<cr>", { desc = "Build Current Project" })
        vim.keymap.set("n", "<leader>zc", "<cmd>Zig check<cr>", { desc = "Check All Current Project Files" })
        vim.keymap.set("n", "<leader>zt", "<cmd>Zig task<cr>", { desc = "Run a build.zig Task" })
      end,
      cmd = { "zls" },
      filetypes = { "zig", "zon" },
      root_dir = util.root_pattern("zls.json", "build.zig"),
    })
  end,
}
