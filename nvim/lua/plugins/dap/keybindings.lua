local dap = require("dap")
local ui = require("dapui")
local u = require("functions.utils")

-- Opens up the debugger tab if it's not currently active
local function dap_start_debugging()
  local has_dap_repl = false
  for _, buf in ipairs(vim.fn.tabpagebuflist()) do
    if vim.bo[buf].filetype == "dap-repl" then
      has_dap_repl = true
      break
    end
  end

  if not has_dap_repl then
    vim.cmd("tabedit %")
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-o>", false, true, true), "n", false)
    ui.toggle({})
  end
  dap.continue({})
end

-- Detaches the debugger
local function dap_end_debug()
  dap.disconnect({ terminateDebuggee = false }, function()
    require("notify")("Debugger detached", vim.log.levels.INFO)
  end)
end

-- Kills the debug process
local function dap_kill_debug_process()
  dap.clear_breakpoints()
  dap.terminate({}, { terminateDebuggee = true }, function()
    vim.cmd.bd()
    u.resize_vertical_splits()
    require("notify")("Debug process killed", vim.log.levels.WARN)
  end)
end

-- Bulk clear all breakpoints
local function dap_clear_breakpoints()
  dap.clear_breakpoints()
  require("notify")("Breakpoints cleared", vim.log.levels.WARN)
end

local function get_args(config)
  local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    local new_args = vim.fn.input("Run with args: ", table.concat(args, " ")) --[[@as string]]
    return vim.split(vim.fn.expand(new_args) --[[@as string]], " ")
  end
  return config
end

vim.keymap.set("n", "<leader>ds", dap_start_debugging, { desc = "Start Debugging" })
vim.keymap.set("n", "<leader>de", dap_end_debug, { desc = "End Debug" })
vim.keymap.set("n", "<leader>dw", require("dap.ui.widgets").hover, { desc = "Hover Widgets" })
vim.keymap.set("n", "<leader>dq", dap_kill_debug_process, { desc = "Kill Debug Process" })
vim.keymap.set("n", "<leader>dC", dap_clear_breakpoints, { desc = "Clear Breakpoints" })
vim.keymap.set("n", "<leader>dB", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Breakpoint Condition" })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
vim.keymap.set("n", "<leader>da", function()
  dap.continue({ before = get_args })
end, { desc = "Run with Args" })
vim.keymap.set("n", "<leader>dR", function()
  dap.run_to_cursor()
end, { desc = "Run to Cursor" })
vim.keymap.set("n", "<leader>dg", dap.goto_, { desc = "Go to Line (No Execute)" })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
vim.keymap.set("n", "<leader>dj", dap.down, { desc = "Down" })
vim.keymap.set("n", "<leader>dk", dap.up, { desc = "Up" })
vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run Last" })
vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step Out" })
vim.keymap.set("n", "<leader>dO", dap.step_over, { desc = "Step Over" })
vim.keymap.set("n", "<leader>dp", dap.pause, { desc = "Pause" })
vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Toggle REPL" })
vim.keymap.set("n", "<leader>dS", dap.session, { desc = "Session" })
vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate" })

-- Dap UI
vim.keymap.set("n", "<leader>du", function()
  ui.toggle({})
end, { desc = "Dap UI" })
vim.keymap.set("n", "<leader>dv", ui.eval, { desc = "Eval" })
