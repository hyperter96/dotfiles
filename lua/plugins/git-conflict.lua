return {
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    optional = false,
    config = function()
      require("git-conflict").setup({
        default_mapping = false,
      })
      vim.keymap.set("n", "<leader>go", "<Plug>(git-conflict-ours)", { desc = "Select the Current Changes" })
      vim.keymap.set("n", "<leader>gt", "<Plug>(git-conflict-theirs)", { desc = "Select the Incoming Changes" })
      vim.keymap.set("n", "<leader>g2", "<Plug>(git-conflict-both)", { desc = "Select Both Changes" })
      vim.keymap.set("n", "<leader>g0", "<Plug>(git-conflict-none)", { desc = "Select None of the Changes" })
      vim.keymap.set(
        "n",
        "<leader>gp",
        "<Plug>(git-conflict-prev-conflict)",
        { desc = "Move to the Previous Conflict" }
      )
      vim.keymap.set("n", "<leader>gn", "<Plug>(git-conflict-next-conflict)", { desc = "Move to the Next Conflict" })
      vim.keymap.set("n", "<leader>gx", "<cmd>GitConflictListQf<cr>", { desc = "List All Conflicts QuickFix" })
    end,
  },
}
