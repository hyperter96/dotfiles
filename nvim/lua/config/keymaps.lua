-- delete default keymaps
vim.keymap.del("n", "<leader>/")
vim.keymap.del("n", "<leader><space>")
vim.keymap.del("n", "<leader>:")
vim.keymap.del("n", "<leader>,")
vim.keymap.del("n", "<leader>`")
vim.keymap.del("n", "<leader>-")
vim.keymap.del("n", "<leader>|")
vim.keymap.del("n", "<leader>K")
vim.keymap.del("n", "<leader>E")
vim.keymap.del("n", "<leader>l")
vim.keymap.del("n", "<leader>L")

-- switch the themes
vim.keymap.set("n", "<c-t>", "<cmd>Telescope themes<cr>")

-- toggle simulator list
vim.keymap.set("n", "<leader>se", "<cmd>Telescope simulators run<cr>", { desc = "Toggle Simulator List" })

-- yank key
vim.keymap.set({ "n", "x" }, "<c-c>", "<Plug>(YankyYank)", { silent = true })
vim.keymap.set("n", "<C-v>", '"+P') -- Paste normal mode
vim.keymap.set("v", "<C-v>", '"+P') -- Paste visual mode
vim.keymap.set("c", "<C-v>", "<C-R>+") -- Paste command mode
vim.keymap.set("i", "<C-v>", '<ESC>"+pa') -- Paste insert mode

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

vim.keymap.set("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
  desc = "Search current word",
})
vim.keymap.set("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
  desc = "Search current word",
})
vim.keymap.set("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
  desc = "Search on current file",
})

-- 绑定快捷键
vim.keymap.set("n", "<leader>ap", ":AvanteProject<CR>", {
  silent = true,
  desc = "avante: AI分析整个项目",
})
