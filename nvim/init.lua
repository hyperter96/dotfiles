-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("plugins.dap")
require("lsp.copilot")
require("git-helpers")
-- require("avante_lib").load()

-- Load highlight configurations
require("highlight")

-- Setup LSP custom configurations
require("lsp.custom")

-- Setup Jupiter Notebook
require("lsp.jupiter-notebook")
