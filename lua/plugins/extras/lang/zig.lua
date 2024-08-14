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
          { "<leader>z", group = "Zig", icon = { icon = "", color = "orange" } },
        },
      },
    },
  },
  {
    "ziglang/zig.vim",
    ft = "zig",
  },
  {
    "NTBBloodbath/zig-tools.nvim",
    -- Load zig-tools.nvim only in Zig buffers
    ft = "zig",
    config = function()
      -- Initialize with default config
      require("zig-tools").setup()
    end,
    requires = {
      {
        "akinsho/toggleterm.nvim",
        config = function()
          require("toggleterm").setup()
        end,
      },
      {
        "nvim-lua/plenary.nvim",
        module_pattern = "plenary.*",
      },
    },
  },
}
