local leet_arg = "leetcode.nvim"

return {
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
      { "<localleader>Lm", "<cmd>Leet<cr>", desc = "Menu" },
      { "<localleader>Lq", "<cmd>Leet exit<cr>", desc = "Exit Leetcode" },
      { "<localleader>LL", "<cmd>Leet lang<cr>", desc = "Change the Language" },
      { "<localleader>Ly", "<cmd>Leet yank<cr>", desc = "Yank the current Question Solution" },
      { "<localleader>Lr", "<cmd>Leet run<cr>", desc = "Run currently Opened Question" },
      { "<localleader>Ls", "<cmd>Leet submit<cr>", desc = "Submit currently Opened Question" },
      { "<localleader>Ll", "<cmd>Leet list<cr>", desc = "Open a Problem List Picker" },
    },
  },
}
