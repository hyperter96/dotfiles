return {
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    build = (not LazyVim.is_win())
        and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
      or nil,
    dependencies = {
      {
        "honza/vim-snippets",
        config = function()
          local cmp = require("cmp")
          local cmp_action = require("lsp-zero").cmp_action()
          local cmp_format = require("lsp-zero").cmp_format({ details = true })
          require("luasnip.loaders.from_snipmate").lazy_load()
          require("luasnip.loaders.from_snipmate").lazy_load({
            paths = vim.fn.stdpath("config") .. "/snippets",
          })

          cmp.setup({
            sources = {
              { name = "nvim_lsp" },
              { name = "luasnip" },
            },
            mapping = cmp.mapping.preset.insert({
              ["<C-f>"] = cmp_action.luasnip_jump_forward(),
              ["<C-b>"] = cmp_action.luasnip_jump_backward(),
            }),
            snippet = {
              expand = function(args)
                require("luasnip").lsp_expand(args.body)
              end,
            },
            --- (Optional) Show source name in completion menu
            formatting = cmp_format,
          })
        end,
      },
      {
        "nvim-cmp",
        dependencies = {
          "saadparwaiz1/cmp_luasnip",
        },
        opts = function(_, opts)
          opts.snippet = {
            expand = function(args)
              require("luasnip").lsp_expand(args.body)
            end,
          }
          table.insert(opts.sources, { name = "luasnip" })
        end,
      },
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
  },
  {
    "nvim-cmp",
    -- stylua: ignore
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true, silent = true, mode = "i",
      },
      { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
  },
  {
    "garymjr/nvim-snippets",
    enabled = false,
  },
  {
    "iurimateus/luasnip-latex-snippets.nvim",
    -- vimtex isn't required if using treesitter
    requires = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
    config = function()
      require("luasnip-latex-snippets").setup()
      -- or setup({ use_treesitter = true })
      require("luasnip").config.setup({ enable_autosnippets = true })
    end,
  },
}
