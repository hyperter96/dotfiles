return {
  {
    "hrsh7th/nvim-cmp",
    event = 'InsertEnter',
    dependencies = {
      {
        "Saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        opts = {
          completion = {
            cmp = { enabled = true },
          },
        },
      },
      'hrsh7th/cmp-buffer', -- source for text in buffer
      'hrsh7th/cmp-path', -- source for file system paths
      'L3MON4D3/LuaSnip', -- snippet engine
      'saadparwaiz1/cmp_luasnip', -- for autocompletion
      'rafamadriz/friendly-snippets', -- useful snippets
      'onsails/lspkind.nvim', -- vs-code like pictograms
      'hrsh7th/cmp-cmdline',
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require('luasnip')
      local lspkind = require('lspkind')

      local cmp_action = require("lsp-zero").cmp_action()

      -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
      require('luasnip.loaders.from_vscode').lazy_load()
      cmp.setup({
        sources = {
          { name = "nvim_lsp" },
          { name = 'luasnip' }, -- snippets
          { name = 'buffer' }, -- text within current buffer
          { name = 'path' }, -- file system paths
          { name = 'py-requirements' },
        },
        snippet = {
          expand = function(args)
            -- You need Neovim v0.10 to use vim.snippet
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          -- enable supertab
          ["<Tab>"] = cmp_action.luasnip_supertab(),
          ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
          ['<C-k>'] = cmp.mapping.select_prev_item(), -- previous suggestion
          ['<C-j>'] = cmp.mapping.select_next_item(), -- next suggestion
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-q>'] = cmp.mapping.abort(), -- close completion window
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
        }),
        completion = {
          completeopt = 'menu,menuone,preview,noselect',
        },

        -- configure lspkind for vs-code like pictograms in completion menu
        formatting = {
          format = lspkind.cmp_format({
            maxwidth = 50,
            ellipsis_char = '...',
          }),
        },
      })

      -- `:` cmdline setup.
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' },
            },
          },
        }),
      })
    end,
    opts = function(_, opts)
      opts.auto_brackets = opts.auto_brackets or {}
      table.insert(opts.auto_brackets, "python")
      opts.sources = opts.sources or {}
      table.insert(opts.sources, { name = "crates" })
    end,
  },
}
