local u = require("utils")
local ufo_u = require("lsp.ufo")
-- local m = u.lazy_map
local c = u.create_cmd

local scale = u.screen_scale({ height = 0.65 })

local opts = {
  fold_virt_text_handler = ufo_u.handler,
  close_fold_kinds_for_ft = {
    typescript = {
      "imports",
      "comment",
    },
    vue = {},
  },
}

return {
  {
    "kevinhwang91/nvim-ufo",
    optional = false,
    event = "VeryLazy",
    opts = opts,
    init = function()
      ufo_u.set_opts()
      c("UfoToggleFold", ufo_u.toggle_fold)
    end,

    config = function()
      -- require("ufo").setup()

      -- Using ufo provider need remap `zR` and `zM`.
      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
      vim.keymap.set("n", "zu", "UfoToggleFold")
    end,
  },
}
