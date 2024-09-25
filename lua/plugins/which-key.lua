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

          -- debug
          { "<leader>d", group = "Debug", icon = { icon = "", color = "red" } },

          -- C++
          { "<leader>C", group = "C++", icon = { icon = "󰙲", color = "blue" } },

          -- DB
          { "<leader>D", group = "DB", icon = { icon = "󱙋", color = "cyan" } },

          -- java
          { "<leader>j", group = "Java", icon = { icon = "", color = "grey" } },

          -- leetcode
          { "<localleader>L", group = "Leetcode", icon = { icon = "", color = "green" } },

          -- tmux
          { "<localleader>t", group = "tmux", icon = { icon = "", color = "orange" } },

          -- LSP Functions
          { "<leader>l", group = "LSP Functions", icon = { icon = "󰒲", color = "blue" } },

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

          -- gpt
          { "<localleader>g", group = "GPT", icon = { icon = "", color = "grey" } },

          -- Rust
          { "<leader>r", group = "Rust", icon = { icon = "󱘗", color = "red" } },

          -- Rust Crates.io
          { "<leader>C", group = "Crates", icon = { icon = "󱘗", color = "red" } },

          -- haskell
          { "<leader>h", group = "haskell", icon = { icon = "", color = "purple" } },

          -- test
          { "<leader>t", group = "test", icon = { icon = "󰇉", color = "sky" } },

          -- octo
          { "<leader>o", group = "octo", icon = { icon = "", color = "grey" } },

          -- chatGPT
          { "<leader>P", group = "ChatGPT", icon = { icon = "󰭹", color = "green" } },

          -- ziglang
          { "<leader>z", group = "Zig", icon = { icon = "", color = "orange" } },

          -- markdown
          { "<leader>m", group = "Markdown", icon = { icon = "", color = "purple" } },

          -- yank
          { "<leader>y", group = "Yank", icon = { icon = "", color = "green" } },

          -- copilot
          { "<leader>k", group = "Copilot", icon = { icon = "", color = "orange" } },
        },
      },
    },
  },
}
