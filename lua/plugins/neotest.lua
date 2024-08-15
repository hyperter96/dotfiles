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
          { "<leader>t", group = "test", icon = { icon = "󰇉", color = "sky" } },
        },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    optional = false,
    dependencies = {
      "lawrence-laz/neotest-zig", -- Installation
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "mrcjkb/neotest-haskell",
      "fredrikaverpil/neotest-golang",
      "nvim-neotest/neotest-python", 
      "alfaix/neotest-gtest",
    },
    opts = {
      adapters = {
        ["neotest-zig"] = {
          dap = {
            adapter = "lldb",
          },
        },
        ["neotest-haskell"] = {
          frameworks = {
            { framework = 'tasty', modules = { 'Test.Tasty', 'MyTestModule' }, },
            'hspec',
            'sydtest',
          },
        },
        ["neotest-golang"] = {
          -- Here we can set options for neotest-golang, e.g.
          -- go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
          dap_go_enabled = true, -- requires leoluz/nvim-dap-go
        },
        ["neotest-gtest"] = {},
        ["rustaceanvim.neotest"] = {},
        ["neotest-python"] = {
          -- Here you can specify the settings for the adapter, i.e.
          runner = "pytest",
          -- python = ".venv/bin/python",
        },
      },
    },
    keys = {
      { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
      { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Test Files" },
      { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
      { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
      { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch" },
    },  
  },
}