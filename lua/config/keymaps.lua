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

-- switch the themes
vim.keymap.set("n", "<c-t>", "<cmd>Telescope themes<cr>")

-- Open compiler
vim.api.nvim_set_keymap("n", "<F6>", "<cmd>CompilerOpen<cr>", { noremap = true, silent = true })

-- Redo last selected option
vim.api.nvim_set_keymap(
  "n",
  "<S-F6>",
  "<cmd>CompilerStop<cr>" -- (Optional, to dispose all tasks before redo)
    .. "<cmd>CompilerRedo<cr>",
  { noremap = true, silent = true }
)

-- Toggle compiler results
vim.api.nvim_set_keymap("n", "<S-F7>", "<cmd>CompilerToggleResults<cr>", { noremap = true, silent = true })

-- Using ufo provider need remap `zR` and `zM`.
vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

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
