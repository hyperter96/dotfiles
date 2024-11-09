return {
  setup = function(dap)
    dap.adapters.node2 = {
      type = "executable",
      command = "node",
      args = { vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
    }

    dap.adapters.go = {
      type = "server",
      port = "${port}",
      executable = {
        command = vim.fn.stdpath("data") .. "/mason/bin/dlv",
        args = { "dap", "-l", "127.0.0.1:${port}" },
      },
    }

    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter", -- Path to VSCode Debugger
        args = { "${port}" },
      },
    }

    -- 配置 C/C++ 使用 codelldb 调试
    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        -- 根据实际情况填写 codelldb 的路径
        command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb",
        args = { "--port", "${port}" },
      },
    }

    -- 配置 Haskell 调试适配器
    dap.adapters.haskell = {
      type = "executable",
      command = vim.fn.stdpath("data") .. "/mason/bin/haskell-debug-adapter", -- ghci-dap 的可执行文件路径
      args = {},
    }

    -- Python
    local mason_registry = require("mason-registry")
    local debugpy_adapter_path = mason_registry.get_package("debugpy"):get_install_path() .. "/debugpy-adapter"
    dap.adapters.python = function(cb, config)
      if config.request == "attach" then
        ---@diagnostic disable-next-line: undefined-field
        local port = (config.connect or config).port
        ---@diagnostic disable-next-line: undefined-field
        local host = (config.connect or config).host or "localhost"
        cb({
          type = "server",
          port = assert(port, "`connect.port` is required for a python `attach` configuration"),
          host = host,
        })
      else
        cb({
          type = "executable",
          command = debugpy_adapter_path,
        })
      end
    end

    dap.adapters.nlua = function(callback, config)
      callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
    end
  end,
}
