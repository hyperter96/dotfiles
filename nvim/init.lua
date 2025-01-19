-- Core plugin management
require("config.lazy") -- Lazy.nvim plugin manager
require("git-helpers") -- Git related utilities

-- Debugging and LSP configurations
require("plugins.dap") -- Debug Adapter Protocol
require("lsp.copilot") -- GitHub Copilot integration
require("lsp.custom") -- Custom LSP configurations
require("lsp.jupiter-notebook") -- Jupyter notebook support

-- UI and highlighting
require("highlight") -- Syntax highlighting configurations
