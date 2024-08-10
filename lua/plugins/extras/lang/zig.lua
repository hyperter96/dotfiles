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
    "nvim-neotest/neotest",
    optional = false,
    dependencies = {
      "lawrence-laz/neotest-zig", -- Installation
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
    },
    opts = {
      adapters = {
        ["neotest-zig"] = {
          dap = {
            adapter = "lldb",
          },
        },
      },
    },
    -- config = function()
    --   require("neotest").setup({
    --     log_level = vim.log.levels.TRACE,
    --     adapters = {
    --       -- Registration
    --       require("neotest-zig")({
    --         dap = {
    --           adapter = "lldb",
    --         },
    --       }),
    --     },
    --   })
    -- end,
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
