return {
  "gbprod/substitute.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local substitute = require("substitute")

    substitute.setup()

    -- set keymaps
    local keymap = vim.keymap -- for conciseness
    -- substitute keyword by pressing viw (selecting the keyword) and pressing siw, that with substitute another keyword
    -- substitute line to the end by viw (selecting the keyword) and pressing s$
    -- substutute the rest content by pressing sG
    keymap.set("n", "s", substitute.operator, { desc = "Substitute with motion" })
    keymap.set("n", "ss", substitute.line, { desc = "Substitute line" })
    keymap.set("n", "S", substitute.eol, { desc = "Substitute to end of line" })
    keymap.set("x", "s", substitute.visual, { desc = "Substitute in visual mode" })
  end,
}
