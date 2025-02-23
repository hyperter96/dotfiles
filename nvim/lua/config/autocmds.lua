vim.api.nvim_create_user_command("AvanteProject", function()
  require("avante.api").ask({
    question = [[
    分析当前项目的以下目录(假如存在以下目录的话)：
    - app/
    - apps/
    - src/
    - include/
    - lib/
    请完成：
    1. 总结模块架构
    2. 找出潜在的性能瓶颈
    3. 生成改进建议
  ]],
  })
end, { desc = "Analyze Project" })

-- python
vim.api.nvim_create_autocmd("FileType", {
  desc = "python ft mappings",
  group = vim.api.nvim_create_augroup("py_mapping", { clear = true }),
  pattern = "python",
  callback = function(opts)
    vim.keymap.set(
      "n",
      "<F4>",
      ":w <bar> exec '!python3 '.shellescape('%')<CR>",
      { desc = "Display Running Result Message" }
    )
  end,
})

-- typescript
-- Remove unused imports on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = vim.api.nvim_create_augroup("ts_imports", { clear = true }),
  pattern = { "*.tsx,*.ts" },
  callback = function()
    vim.lsp.buf.code_action({ apply = true, context = { only = { "source.addMissingImports.ts" }, diagnostics = {} } })
    vim.lsp.buf.code_action({
      apply = true,
      context = {
        only = { "source.removeUnused.ts" },
        diagnostics = {},
      },
    })
  end,
})

-- C/C++
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "c", "cpp", "md", "txt", "c.snippets", "cpp.snippets" },
  callback = function()
    vim.b.autoformat = true
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
  end,
  desc = "Highlights the yanked text",
})

-- 文件类型检测配置
vim.api.nvim_exec2(
  [[
  augroup FileTypeMustache
    autocmd!
    autocmd BufNewFile,BufRead *.mustache set filetype=mustache
    autocmd BufNewFile,BufRead *.hbs set filetype=mustache
  augroup END

  augroup FileTypeGoTemplate
    autocmd!
    autocmd BufNewFile,BufRead *.tmpl set filetype=gotmpl
    autocmd BufNewFile,BufRead *.gohtml set filetype=gotmpl
  augroup END
]],
  { output = false }
)
vim.g.handlebars_no_default_keybindings = 1
vim.g.mustache_abbreviations = 1

-- Taken from: https://stackoverflow.com/questions/4292733/vim-creating-parent-directories-on-save
vim.cmd([[
  function s:MkNonExDir(file, buf)
      if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
          let dir=fnamemodify(a:file, ':h')
          if !isdirectory(dir)
              call mkdir(dir, 'p')
          endif
      endif
  endfunction
  augroup BWCCreateDir
      autocmd!
      autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
  augroup END
]])

local augroups = {}

local cursor_pos
augroups.yankpost = {
  save_cursor_position = {
    event = { "VimEnter", "CursorMoved" },
    pattern = "*",
    callback = function()
      cursor_pos = vim.fn.getpos(".")
    end,
  },
  highlight_yank = {
    event = "TextYankPost",
    pattern = "*",
    callback = function()
      vim.highlight.on_yank({ higroup = "IncSearch", timeout = 400, on_visual = true })
    end,
  },
  yank_restore_cursor = {
    event = "TextYankPost",
    pattern = "*",
    callback = function()
      if vim.v.event.operator == "y" then
        vim.fn.setpos(".", cursor_pos)
      end
    end,
  },
}

vim.api.nvim_set_hl(0, "Lime", { bg = "Lime" })
vim.api.nvim_set_hl(0, "Emerald", { bg = "#047857" })
vim.api.nvim_set_hl(0, "Indigo", { bg = "#3730a3" })
vim.api.nvim_set_hl(0, "Blue", { bg = "#1e40af" })
