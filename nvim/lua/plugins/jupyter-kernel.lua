return {
  "lkhphuc/jupyter-kernel.nvim",
  opts = {
    inspect = {
      -- opts for vim.lsp.util.open_floating_preview
      window = {
        max_width = 84,
      },
    },
    -- time to wait for kernel's response in seconds
    timeout = 0.5,
  },
  cmd = { "JupyterAttach", "JupyterInspect", "JupyterExecute" },
  build = ":UpdateRemotePlugins",
  keys = {
    { "<leader>MI", "<Cmd>JupyterInspect<CR>", desc = "Inspect object in Kernel" },
    { "<leader>MA", "<Cmd>JupyterAttach<CR>", desc = "Attach to Jupyter Kernel" },
    { "<leader>MD", "<Cmd>JupyterDetach<CR>", desc = "Detach Buffer from Kernel" },
  },
}
