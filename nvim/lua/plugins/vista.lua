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
          { "<leader>v", group = "Vista", icon = { icon = "󰠶", color = "cyan" } },
        },
      },
    },
  },
  {
    "liuchengxu/vista.vim",
    keys = {
      { "<leader>vq", "<cmd>Vista!<cr>", desc = "Close Vista View Window" },
      { "<leader>vt", "<cmd>Vista!!<cr>", desc = "Toggle Vista View Window" },
      { "<leader>vb", "<cmd>Vista focus<cr>", desc = "Jump between Vista Sidebar & Source Code Window" },
      { "<leader>vf", "<cmd>Vista finder<cr>", desc = "Search Tags/Symbols Generated from fzf" },
      { "<leader>vs", "<cmd>Vista show<cr>", desc = "Jump to the Tag Nearby the Current Cursor" },
      { "<leader>vc", "<cmd>Vista toc<cr>", desc = "Show toc of .md File" },
    },
  },
}
