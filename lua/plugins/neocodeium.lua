return {
  "monkoose/neocodeium",
  event = "VeryLazy",
  enabled = true,
  config = function()
    local filetypes = { "python", "java", "cpp", "rust", "go", "haskell", "typescript", "javascript" }
    local neocodeium = require("neocodeium")
    neocodeium.setup({
      enabled = true,
      show_label = true,
      manual = false,
      debounce = true,
      silent = true,
      filetypes = {
        help = false,
        gitcommit = false,
        gitrebase = false,
        ["."] = false,
      },
      -- function accepts one argument `bufnr`
      filter = function(bufnr)
        if vim.tbl_contains(filetypes, vim.api.nvim_get_option_value("filetype", { buf = bufnr })) then
          return true
        end
        return false
      end,
    })
    vim.keymap.set("i", "<A-f>", neocodeium.accept)
    -- vim.keymap.set("i", "<c-'>", neocodeium.cleareium").accept_word()
    -- end)
    vim.keymap.set("i", "<A-l>", neocodeium.accept_line)
    vim.keymap.set("i", "<A-c>", neocodeium.cycle_or_complete)
    vim.keymap.set("i", "<A-b>", function()
      neocodeium.cycle_or_complete(-1)
    end)
    vim.keymap.set("i", "<A-q>", neocodeium.clear)
  end,
}
