local opt = vim.opt

-- support Spanish & Chinese character spell
opt.spelllang = { "en", "es", "cjk" }
opt.spell = false

vim.g.maplocalleader = ","

-- virtual env path for python3
-- vim.g.python3_host_prog=vim.fn.expand("~/.virtualenvs/neovim/bin/python3")
