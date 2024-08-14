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
          { "<localleader>R", group = "Rest", icon = { icon = "󰒲", color = "blue" } },
        },
      },
    },
  },
  {
    'mistweaverco/kulala.nvim',
    config = function()
      -- Setup is required, even if you don't pass any options
      require('kulala').setup()
    end,
    ft = "http",
    keys = {
      { "<localleader>Rs", "<cmd>lua require('kulala').run()<cr>", desc = "Send the request" },
      { "<localleader>Rt", "<cmd>lua require('kulala').toggle_view()<cr>", desc = "Toggle headers/body" },
      { "<localleader>Rp", "<cmd>lua require('kulala').jump_prev()<cr>", desc = "Jump to previous request" },
      { "<localleader>Rn", "<cmd>lua require('kulala').jump_next()<cr>", desc = "Jump to next request" },
    },
  },
}
