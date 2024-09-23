-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("plugins.dap")

require("git-helpers")
require("telescope").setup({
  pickers = {
    colorscheme = {
      enable_preview = true,
    },
  },
})

local lspconfig = require("lspconfig")

-- 自定义 clangd 的配置
lspconfig.clangd.setup({
  on_attach = function(client, bufnr)
    -- 如果文件类型是 proto，禁用 clangd
    local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
    if filetype == "proto" then
      client.stop()
    end
  end,
})

require("highlight")
