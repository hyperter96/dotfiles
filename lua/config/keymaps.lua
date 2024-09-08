-- delete default keymaps
vim.keymap.del("n", "<leader>/")
vim.keymap.del("n", "<leader><space>")
vim.keymap.del("n", "<leader>:")
vim.keymap.del("n", "<leader>,")
vim.keymap.del("n", "<leader>`")
vim.keymap.del("n", "<leader>-")
vim.keymap.del("n", "<leader>|")
vim.keymap.del("n", "<leader>K")
vim.keymap.del("n", "<leader>l")
vim.keymap.del("n", "<leader>L")
vim.keymap.del({ "n", "x" }, "y")

-- switch the themes
vim.keymap.set("n", "<c-t>", "<cmd>Telescope themes<cr>")

-- yank key
vim.keymap.set({ "n", "x" }, "<c-c>", "<Plug>(YankyYank)", { silent = true })

local wk = require("which-key")
wk.add({
  mode = { "v" },
  { "<leader>S", group = "Silicon", icon = { icon = "󰹑" } },
  {
    "<leader>Sc",
    function()
      require("nvim-silicon").clip()
    end,
    desc = "Copy code screenshot to clipboard",
  },
  {
    "<leader>Sf",
    function()
      require("nvim-silicon").file()
    end,
    desc = "Save code screenshot as file",
  },
  {
    "<leader>Ss",
    function()
      require("nvim-silicon").shoot()
    end,
    desc = "Create code screenshot",
  },
})

local buffers = require("utils.buffers")
local is_default_buffer = function()
  return buffers.is_not_focused_buffer("NvimTree_1", "mind")
end

-- ollama
vim.keymap.set("n", "<localleader>gm", function()
  if is_default_buffer() then
    local menu = require("plugins.extras.pickers.ollama")
    menu.toggle()
  end
end)

-- nvim-spectre
vim.keymap.set("n", "<C-a>", function()
  if is_default_buffer() then
    local menu = require("plugins.extras.pickers.spectre")
    menu.toggle()
  end
end)
