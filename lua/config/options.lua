local opt = vim.opt

-- support Spanish & Chinese character spell
opt.spelllang = { "en", "es", "cjk" }
opt.spell = false

vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
