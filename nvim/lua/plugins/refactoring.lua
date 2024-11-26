return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  lazy = false,
  config = function()
    require("refactoring").setup()
    vim.keymap.set("x", "<leader>Fe", ":Refactor extract ")
    vim.keymap.set("x", "<leader>Ff", ":Refactor extract_to_file ")

    vim.keymap.set("x", "<leader>Fv", ":Refactor extract_var ")

    vim.keymap.set({ "n", "x" }, "<leader>Fi", ":Refactor inline_var")

    vim.keymap.set("n", "<leader>FI", ":Refactor inline_func")

    vim.keymap.set("n", "<leader>Fb", ":Refactor extract_block")
    vim.keymap.set("n", "<leader>Fbf", ":Refactor extract_block_to_file")
  end,
}
