-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("plugins.dap")
require("lsp.copilot")
require("git-helpers")
-- require("avante_lib").load()

-- Setup Telescope
require("telescope").setup({
  pickers = {
    colorscheme = {
      enable_preview = true,
    },
  },
})

-- Load highlight configurations
require("highlight")

-- Setup LSP custom configurations
require("lsp.custom")
