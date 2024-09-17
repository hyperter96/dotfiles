return {
  {
    "jackMort/ChatGPT.nvim",
    optional = true,
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup({
        api_key_cmd = "pass show neovim/hyperter96",
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<leader>Pc", "<cmd>ChatGPT<CR>", "ChatGPT" },
      { "<leader>Pe", "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction", mode = { "n", "v" } },
      { "<leader>Pg", "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction", mode = { "n", "v" } },
      { "<leader>Pt", "<cmd>ChatGPTRun translate<CR>", "Translate", mode = { "n", "v" } },
      { "<leader>Pk", "<cmd>ChatGPTRun keywords<CR>", "Keywords", mode = { "n", "v" } },
      { "<leader>Pd", "<cmd>ChatGPTRun docstring<CR>", "Docstring", mode = { "n", "v" } },
      { "<leader>Pa", "<cmd>ChatGPTRun add_tests<CR>", "Add Tests", mode = { "n", "v" } },
      { "<leader>Po", "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code", mode = { "n", "v" } },
      { "<leader>Ps", "<cmd>ChatGPTRun summarize<CR>", "Summarize", mode = { "n", "v" } },
      { "<leader>Pf", "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs", mode = { "n", "v" } },
      { "<leader>Px", "<cmd>ChatGPTRun explain_code<CR>", "Explain Code", mode = { "n", "v" } },
      { "<leader>Pr", "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit", mode = { "n", "v" } },
      {
        "<leader>Pl",
        "<cmd>ChatGPTRun code_readability_analysis<CR>",
        "Code Readability Analysis",
        mode = { "n", "v" },
      },
    },
  },
}
