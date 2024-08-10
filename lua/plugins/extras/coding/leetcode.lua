local leet_arg = "leetcode.nvim"

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
          { "<leader>L", group = "Leetcode", icon = { icon = "", color = "green" } },
        },
      },
    },
  },
  {
    "kawre/leetcode.nvim",
    lazy = leet_arg ~= vim.fn.argv()[1],
    build = ":TSUpdate html",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim", -- required by telescope
      "MunifTanjim/nui.nvim",

      -- optional
      "nvim-treesitter/nvim-treesitter",
      "rcarriga/nvim-notify",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      lang = "golang",
      arg = leet_arg,
      cn = { -- leetcode.cn
        enabled = true,
        translator = true,
        translate_problems = true,
      },
      injector = {
        ["python3"] = {
          before = true,
        },
        ["cpp"] = {
          before = { "#include <bits/stdc++.h>", "using namespace std;" },
          after = "int main() {}",
        },
        ["java"] = {
          before = "import java.util.*;",
        },
      },
    },
    keys = {
      { "<leader>Lm", "<cmd>Leet<cr>", desc = "Menu" },
      { "<Leader>Lq", "<cmd>Leet exit<cr>", desc = "Exit Leetcode" },
      { "<Leader>LL", "<cmd>Leet lang<cr>", desc = "Change the Language" },
      { "<leader>Ly", "<cmd>Leet yank<cr>", desc = "Yank the current Question Solution" },
      { "<leader>Lr", "<cmd>Leet run<cr>", desc = "Run currently Opened Question" },
      { "<leader>Ls", "<cmd>Leet submit<cr>", desc = "Submit currently Opened Question" },
      { "<leader>Ll", "<cmd>Leet list<cr>", desc = "Open a Problem List Picker" },
    },
  },
}
