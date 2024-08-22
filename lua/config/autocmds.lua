-- python
vim.api.nvim_create_autocmd("FileType", {
  desc = "python ft mappings",
  group = vim.api.nvim_create_augroup("py_mapping", { clear = true }),
  pattern = "python",
  callback = function(opts)
      vim.keymap.set("n", "<F4>", ":w <bar> exec '!python3 '.shellescape('%')<CR>", { desc = "Display Running Result Message"})
  end
})

-- C/C++
vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = {"c", "cpp", "md", "txt", "c.snippets", "cpp.snippets"},
    callback = function()
        vim.b.autoformat = true
        vim.opt_local.expandtab = true
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.softtabstop = 4
    end,
})

-- Run gofmt + goimport on save
local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require("go.format").goimport()
  end,
  group = format_sync_grp,
})
