return {
  {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvimtools/hydra.nvim",
    },
    opts = {},
    cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
    keys = {
      {
        mode = { "v", "n" },
        "<Leader>ct",
        "<cmd>MCstart<cr>",
        desc = "Create a selection for selected text or word under the cursor",
      },
      {
        mode = { "v" },
        "<leader>cv",
        "<cmd>MCvisual<cr>",
        desc = "Select the last visual mode selection and start listening for the actions",
      },
      {
        mode = { "v", "n" },
        "<leader>cp",
        "<cmd>MCpattern<cr>",
        desc = "Prompts for a pattern and selects every match in the buffer",
      },
      {
        mode = { "v", "n" },
        "<leader>cu",
        "<cmd>MCunderCursor",
        desc = "Select the char under the cursor and start listening for the actions",
      },
    },
  },
}
