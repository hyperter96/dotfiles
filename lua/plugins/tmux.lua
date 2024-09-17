return {
  {
    "aserowy/tmux.nvim",
    config = function()
      return require("tmux").setup()
    end,
  },
  {
    "alexghergh/nvim-tmux-navigation",
    config = function()
      local nvim_tmux_nav = require("nvim-tmux-navigation")

      nvim_tmux_nav.setup({
        disable_when_zoomed = true, -- defaults to false
      })

      vim.keymap.set("n", "<localleader>th", nvim_tmux_nav.NvimTmuxNavigateLeft, { desc = "Tmux Navigate Left" })
      vim.keymap.set("n", "<localleader>tj", nvim_tmux_nav.NvimTmuxNavigateDown, { desc = "Tmux Navigate Down" })
      vim.keymap.set("n", "<localleader>tk", nvim_tmux_nav.NvimTmuxNavigateUp, { desc = "Tmux Navigate Up" })
      vim.keymap.set("n", "<localleader>tl", nvim_tmux_nav.NvimTmuxNavigateRight, { desc = "Tmux Navigate Right" })
      vim.keymap.set(
        "n",
        "<localleader>tL",
        nvim_tmux_nav.NvimTmuxNavigateLastActive,
        { desc = "Tmux Navigate Last Active" }
      )
      vim.keymap.set("n", "<localleader>ts", nvim_tmux_nav.NvimTmuxNavigateNext, { desc = "Tmux Navigate Next" })
    end,
  },
}
