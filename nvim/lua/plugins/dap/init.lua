local u = require("functions.utils")
return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "jay-babu/mason-nvim-dap.nvim",
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
    "williamboman/mason.nvim",
  },
  config = function()
    local adapters = require("plugins.dap.adapters")
    local configurations = require("plugins.dap.configs")

    local mason = require("mason")
    local mason_dap = require("mason-nvim-dap")
    local dap = require("dap")
    local ui = require("dapui")

    -- dap.set_log_level("TRACE")

    -- ╭──────────────────────────────────────────────────────────╮
    -- │ Debuggers                                                │
    -- ╰──────────────────────────────────────────────────────────╯
    -- We need the actual programs to connect to running instances of our code.
    -- Debuggers are installed via https://github.com/jayp0521/mason-nvim-dap.nvim
    mason.setup()
    mason_dap.setup({
      ensure_installed = { "javadbg", "javatest", "delve", "node2", "js", "codelldb", "haskell", "python" },
      automatic_installation = true,
    })

    -- ╭──────────────────────────────────────────────────────────╮
    -- │ Adapters                                                 │
    -- ╰──────────────────────────────────────────────────────────╯
    -- Neovim needs a debug adapter with which it can communicate. Neovim can either
    -- launch the debug adapter itself, or it can attach to an existing one.
    -- To tell Neovim if it should launch a debug adapter or connect to one, and if
    -- so, how, you need to configure them via the `dap.adapters` table.
    adapters.setup(dap)

    -- ╭──────────────────────────────────────────────────────────╮
    -- │ Configuration                                            │
    -- ╰──────────────────────────────────────────────────────────╯
    -- In addition to launching (possibly) and connecting to a debug adapter, Neovim
    -- needs to instruct the adapter itself how to launch and connect to the program
    -- that you are trying to debug (the debugee).
    configurations.setup(dap)

    -- ╭──────────────────────────────────────────────────────────╮
    -- │ Keybindings + UI                                         │
    -- ╰──────────────────────────────────────────────────────────╯
    vim.fn.sign_define("DapBreakpoint", { text = "🐞" })

    require("plugins.dap.keybindings")

    -- UI Settings
    ui.setup({
      controls = {
        element = "repl",
        enabled = true,
        icons = {
          disconnect = "",
          pause = "",
          play = "",
          run_last = "",
          step_back = "",
          step_into = "",
          step_out = "",
          step_over = "",
          terminate = "",
        },
      },
      element_mappings = {},
      expand_lines = true,
      floating = {
        border = "single",
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      force_buffers = true,
      icons = {
        collapsed = "",
        current_frame = "",
        expanded = "",
      },
      layouts = {
        {
          elements = {
            "scopes",
          },
          size = 0.3,
          position = "bottom",
        },
        {
          elements = {
            "repl",
            "breakpoints",
          },
          size = 0.3,
          position = "right",
        },
      },
      mappings = {
        edit = "e",
        expand = { "t", "<2-LeftMouse>" },
        remove = "d",
        repl = {},
        open = {},
        toggle = {},
      },
      render = {
        indent = 1,
        max_value_lines = 100,
      },
    })
  end,
}
