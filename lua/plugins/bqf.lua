vim.cmd([[
    hi BqfPreviewBorder guifg=#3e8e2d ctermfg=71
    hi BqfPreviewTitle guifg=#3e8e2d ctermfg=71
    hi BqfPreviewThumb guibg=#3e8e2d ctermbg=71
    hi link BqfPreviewRange Search
]])

local opts = {
  auto_enable = true,
  auto_resize_height = true,
  preview = {
    win_height = 12,
    win_vheight = 12,
    delay_syntax = 80,
    border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
    show_title = false,
    should_preview_cb = function(bufnr, qwinid)
      local ret = true
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      local fsize = vim.fn.getfsize(bufname)
      if fsize > 100 * 1024 then
        -- skip file size greater than 100k
        ret = false
      elseif bufname:match("^fugitive://") then
        -- skip fugitive buffer
        ret = false
      end
      return ret
    end,
  },
  func_map = {
    open = "<cr>",
    openc = "o",
    vsplit = "v",
    split = "s",
    tab = "t",
    tabc = "T",
    stoggledown = "<Tab>",
    stoggleup = "<S-Tab>",
    stogglevm = "<Tab>",
    sclear = "z<Tab>",
    pscrollup = "<C-f>",
    pscrolldown = "<C-b>",
    fzffilter = "zf",
    ptogglemode = "zp",
    filter = "zn",
    filterr = "zr",
    prevfile = "<C-p>",
    nextfile = "<C-n>",
    prevhist = "<",
    nexthist = ">",
  },
}

return {
  "kevinhwang91/nvim-bqf",
  opts = opts,
  ft = "qf",
  dependencies = {
    "junegunn/fzf",
    build = function()
      vim.fn["fzf#install"]()
    end,
  },
  enabled = true,
}
