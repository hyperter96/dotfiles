return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec" },
    opts = {
      defaults = {},
      spec = {
        {
          mode = { "n", "v" },
          { "<leader>D", group = "DB", icon = { icon = "󱙋", color = "cyan" } },
        },
      },
    },
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
    keys = {
      { "<leader>DU", "<cmd>DBUI<cr>", desc = "Open DBUI" },
      { "<leader>Dt", "<cmd>DBUIToggle<cr>", desc = "Toggle DBUI" },
      { "<leader>DA", "<cmd>DBUIAddConnection<cr>", desc = "Add Connection for DBUI" },
      { "<leader>Df", "<cmd>DBUIFindBuffer<cr>", desc = "Find Buffer for DBUI" },
    },
  },
  {
    "tpope/vim-dadbod",
  },
}
