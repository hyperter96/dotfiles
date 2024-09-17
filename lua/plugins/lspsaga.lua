return {
  {
    "nvimdev/lspsaga.nvim",
    optional = false,
    config = function()
      require("lspsaga").setup({})
      vim.keymap.set("n", "<leader>lh", "<cmd>Lspsaga hover_doc<cr>", { desc = "Hover Declaration" })
      vim.keymap.set("n", "<leader>lp", "<cmd>Lspsaga peek_definition<cr>", { desc = "Invoke Definition" })
      vim.keymap.set("n", "<leader>ly", "<cmd>Lspsaga peek_type_definition<cr>", { desc = "Invoke Type Definition" })
      vim.keymap.set("n", "<leader>ld", "<cmd>Lspsaga goto_definition<cr>", { desc = "Goto Definition" })
      vim.keymap.set("n", "<leader>lt", "<cmd>Lspsaga goto_type_definition<cr>", { desc = "Goto Type Definition" })
      vim.keymap.set("n", "<leader>li", "<cmd>Lspsaga incoming_calls<cr>", { desc = "Incoming Calls" })
      vim.keymap.set("n", "<leader>lo", "<cmd>Lspsaga outgoing_calls<cr>", { desc = "Outgoing Calls" })
      vim.keymap.set("n", "<leader>lf", "<cmd>Lspsaga finder<cr>", { desc = "Show References & Implementations" })
      -- vim.keymap.set('n', '<leader>ls', '<cmd>Lspsaga outline<cr>', {desc = "Toggle the Outline by Sidebar"})
    end,
  },
}
