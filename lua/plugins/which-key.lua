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
          -- C++
          { "<leader>C", group = "C++", icon = { icon = "󰙲", color = "blue" } },

          -- DB
          { "<leader>D", group = "DB", icon = { icon = "󱙋", color = "cyan" } },

          -- java
          { "<leader>j", group = "Java", icon = { icon = "", color = "grey" } },

          -- leetcode
          { "<localleader>L", group = "Leetcode", icon = { icon = "", color = "green" } },

          -- lazy
          { "<leader>l", group = "Lazy", icon = { icon = "󰒲", color = "blue" } },

          -- npm
          { "<leader>n", group = "NPM", icon = { icon = "", color = "red" } },
          { "<leader>wH", "<C-W>v", desc = "Split window horizontally", remap = true },

          -- Go
          { "<leader>G", group = "Go", icon = { icon = "󰟓 ", color = "blue" } },
          { "<leader>Ga", group = "Add", icon = { icon = "󰟓 ", color = "blue" } },
          { "<leader>Gt", group = "Test", icon = { icon = "󰟓 ", color = "blue" } },
          { "<leader>GD", group = "Debug", icon = { icon = "󰟓 ", color = "blue" } },
          { "<leader>GG", group = "Ginkgo", icon = { icon = "󰟓 ", color = "blue" } },

          -- perfanno
          { "<localleader>p", group = "Perfanno", icon = { icon = "", color = "orange" } },
          { "<localleader>pl", group = "PerfLoad", icon = { icon = "", color = "orange" } },

          -- kulala
          { "<localleader>R", group = "Rest", icon = { icon = "󰒲", color = "blue" } },

          -- Rust
          { "<leader>r", group = "Rust", icon = { icon = "󱘗", color = "red" } },

          -- Rust Crates.io
          { "<leader>C", group = "Crates", icon = { icon = "󱘗", color = "red" } },

          -- haskell
          { "<leader>h", group = "haskell", icon = { icon = "", color = "purple" } },

          -- test
          { "<leader>t", group = "test", icon = { icon = "󰇉", color = "sky" } },

          -- chatGPT
          { "<leader>P", group = "ChatGPT", icon = { icon = "󰭹", color = "green" } },
        },
      },
    },
  },
}
