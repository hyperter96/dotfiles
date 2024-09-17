return {
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

      local data_path = vim.fn.stdpath("data")

      vim.g.db_ui_auto_execute_table_helpers = 1
      vim.g.db_ui_save_location = data_path .. "/dadbod_ui"
      vim.g.db_ui_show_database_icon = true
      vim.g.db_ui_tmp_query_location = data_path .. "/dadbod_ui/tmp"
      vim.g.db_ui_use_nerd_fonts = true
      vim.g.db_ui_use_nvim_notify = true

      -- NOTE: The default behavior of auto-execution of queries on save is disabled
      -- this is useful when you have a big query that you don't want to run every time
      -- you save the file running those queries can crash neovim to run use the
      -- default keymap: <leader>S
      vim.g.db_ui_execute_on_save = false
    end,
    keys = {
      { "<leader>DU", "<cmd>DBUI<cr>", desc = "Open DBUI" },
      { "<leader>Dt", "<cmd>DBUIToggle<cr>", desc = "Toggle DBUI" },
      { "<leader>DA", "<cmd>DBUIAddConnection<cr>", desc = "Add Connection for DBUI" },
      { "<leader>Df", "<cmd>DBUIFindBuffer<cr>", desc = "Find Buffer for DBUI" },
    },
  },
  {
    "napisani/nvim-dadbod-bg",
    build = "./install.sh",
    -- (optional) the default port is 4546
    -- (optional) the log file will be created in the system's temp directory
    config = function()
      vim.cmd([[
        let g:nvim_dadbod_bg_port = '4546'
        let g:nvim_dadbod_bg_log_file = '/tmp/nvim-dadbod-bg.log'
      ]])
    end,
  },
  {
    "tpope/vim-dadbod",
  },
}
