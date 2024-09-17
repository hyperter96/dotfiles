local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")
local cmp_format = require("lsp-zero").cmp_format({ details = true })
local cmp_action = require("lsp-zero").cmp_action()

-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
require("luasnip.loaders.from_snipmate").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load({
  paths = vim.fn.stdpath("config") .. "/snippets",
})

luasnip.setup({
  history = true,
  delete_check_events = "TextChanged",
})

cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" }, -- snippets
    { name = "buffer" }, -- text within current buffer
    { name = "path" }, -- file system paths
    { name = "py-requirements" },
  },
  snippet = {
    expand = function(args)
      -- You need Neovim v0.10 to use vim.snippet
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    -- enable supertab
    -- ["<Tab>"] = cmp_action.luasnip_supertab(),
    -- ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
    ["<C-f>"] = cmp_action.luasnip_jump_forward(),
    ["<C-b>"] = cmp_action.luasnip_jump_backward(),
    ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
    ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-q>"] = cmp.mapping.abort(), -- close completion window
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
  }),
  completion = {
    completeopt = "menu,menuone,preview,noselect",
  },

  -- configure lspkind for vs-code like pictograms in completion menu
  formatting = cmp_format,
})

-- `:` cmdline setup.
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    {
      name = "cmdline",
      option = {
        ignore_cmds = { "Man", "!" },
      },
    },
  }),
})
