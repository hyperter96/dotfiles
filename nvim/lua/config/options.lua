local opt = vim.opt
opt.guifont = "Hack Nerd Font:h11"

-- support Spanish & Chinese character spell
opt.spelllang = { "en", "es", "cjk" }
opt.spell = false
opt.wrap = true
vim.g.lazyvim_cmp = "nvim-cmp"
-- conceal level
opt.conceallevel = 0
opt.relativenumber = false
vim.g.maplocalleader = ","
vim.g.mapleader = " "
-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3

if vim.g.neovide then
  vim.o.guifont = "Hack Nerd Font:h11"
  -- Helper function for transparency formatting
  local alpha = function()
    return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
  end
  -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
  vim.g.neovide_transparency = 0.85
  vim.g.transparency = 0.8
  vim.g.neovide_background_color = "#0f1117" .. alpha()

  vim.g.neovide_theme = "dark"

  vim.g.neovide_window_blurred = true
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
vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim/bin/python")
-- I find auto open annoying, keep in mind setting this option will require setting
-- a keybind for `:noautocmd MoltenEnterOutput` to open the output again
vim.g.molten_auto_open_output = false

-- this guide will be using image.nvim
-- Don't forget to setup and install the plugin if you want to view image outputs
vim.g.molten_image_provider = "image.nvim"

-- optional, I like wrapping. works for virt text and the output window
vim.g.molten_wrap_output = true

-- Output as virtual text. Allows outputs to always be shown, works with images, but can
-- be buggy with longer images
vim.g.molten_virt_text_output = true

-- this will make it so the output shows up below the \`\`\` cell delimiter
vim.g.molten_virt_lines_off_by_1 = true
