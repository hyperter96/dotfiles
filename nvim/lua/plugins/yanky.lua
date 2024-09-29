-- better yank/paste
return {
  "gbprod/yanky.nvim",
  recommended = true,
  desc = "Better Yank/Paste",
  event = "LazyFile",
  opts = {
    highlight = { timer = 150 },
  },
  keys = {
    {
      "<leader>yh",
      function()
        if LazyVim.pick.picker.name == "telescope" then
          require("telescope").extensions.yank_history.yank_history({})
        else
          vim.cmd([[YankyRingHistory]])
        end
      end,
      mode = { "n", "x" },
      desc = "Open Yank History",
    },
    -- stylua: ignore
    {
      "<leader>yt",
      "<Plug>(YankyYank)",
      mode = { "n", "x" },
      desc = "Yank Text"
    },
    {
      "<leader>y>",
      "<Plug>(YankyPutAfter)",
      mode = { "n", "x" },
      desc = "Put Text After Cursor",
    },
    {
      "<leader>y<",
      "<Plug>(YankyPutBefore)",
      mode = { "n", "x" },
      desc = "Put Text Before Cursor",
    },
    {
      "<leader>ys",
      "<Plug>(YankyGPutAfter)",
      mode = { "n", "x" },
      desc = "Put Text After Selection",
    },
    {
      "<leader>yS",
      "<Plug>(YankyGPutBefore)",
      mode = { "n", "x" },
      desc = "Put Text Before Selection",
    },
    { "<leader>yc", "<Plug>(YankyCycleForward)", desc = "Cycle Forward Through Yank History" },
    { "<leader>yC", "<Plug>(YankyCycleBackward)", desc = "Cycle Backward Through Yank History" },
    { "<leader>yi", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put Indented After Cursor (Linewise)" },
    { "<leader>yI", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put Indented Before Cursor (Linewise)" },
    { "<leader>yr", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and Indent Right" },
    { "<leader>yl", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and Indent Left" },
    { "<leader>yf", "<Plug>(YankyPutAfterFilter)", desc = "Put After Applying a Filter" },
    { "<leader>yF", "<Plug>(YankyPutBeforeFilter)", desc = "Put Before Applying a Filter" },
  },
}
