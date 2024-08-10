return {
  {
    "LunarVim/bigfile.nvim",
    event = "BufReadPre",
    opts = {
      filesize = 2, -- file size in MiB
    },
    config = function(_, opts)
      require("bigfile").setup(opts)
    end,
  },
}
