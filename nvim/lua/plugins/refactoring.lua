return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  lazy = false,
  config = function()
    require("refactoring").setup()
    vim.keymap.set("x", "<leader>Re", ":Refactor extract ")
    vim.keymap.set("x", "<leader>Rf", ":Refactor extract_to_file ")

    vim.keymap.set("x", "<leader>Rv", ":Refactor extract_var ")

    vim.keymap.set({ "n", "x" }, "<leader>Ri", ":Refactor inline_var")

    vim.keymap.set("n", "<leader>RI", ":Refactor inline_func")

    vim.keymap.set("n", "<leader>Rb", ":Refactor extract_block")
    vim.keymap.set("n", "<leader>Rbf", ":Refactor extract_block_to_file")
  end,
}
