local opt = vim.opt

-- support Spanish & Chinese character spell
opt.spelllang = { "en", "es", "cjk" }
opt.spell = false
opt.wrap = true

-- conceal level
opt.conceallevel = 0

vim.g.maplocalleader = ","

if vim.g.neovide then
  vim.o.guifont = "Hack Nerd Font:h12"
  -- Helper function for transparency formatting
  local alpha = function()
    return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
  end
  -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
  vim.g.neovide_transparency = 0.85
  vim.g.transparency = 0.8
  vim.g.neovide_background_color = "#0f1117" .. alpha()

  vim.g.neovide_theme = "dark"

  vim.g.neovide_floating_blur_amount_x = 4.0
  vim.g.neovide_floating_blur_amount_y = 4.0
  vim.g.floaterm_winblend = 15
  vim.g.neovide_remember_window_size = true

  vim.g.neovide_padding_top = 10
  vim.g.neovide_padding_bottom = 10
  vim.g.neovide_padding_right = 10
  vim.g.neovide_padding_left = 10

  vim.g.neovide_floating_shadow = true
  vim.g.neovide_floating_z_height = 10
  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_radius = 5

  vim.g.clipboard = false
  vim.keymap.set("n", "<C-v>", '"+P') -- Paste normal mode
  vim.keymap.set("v", "<C-v>", '"+P') -- Paste visual mode
  vim.keymap.set("c", "<C-v>", "<C-R>+") -- Paste command mode
  vim.keymap.set("i", "<C-v>", '<ESC>"+pa') -- Paste insert mode
end

-- virtual env path for python3
-- vim.g.python3_host_prog=vim.fn.expand("~/.virtualenvs/neovim/bin/python3")
