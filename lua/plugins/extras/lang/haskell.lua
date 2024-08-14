return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec" },
    opts = {
      defaults = {},
      spec = {
        {
          mode = { "n", "v" },
          { "<leader>h", group = "haskell", icon = { icon = "", color = "purple" } },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    optional = false,
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = { ensure_installed = { "haskell-debug-adapter" } },
      },
    },
  },
  {
    "luc-tielen/telescope_hoogle",
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
    },
    config = function()
      local ok, telescope = pcall(require, "telescope")
      if ok then
        telescope.load_extension("hoogle")
      end
    end,
  },
  { "L3MON4D3/LuaSnip" },
  {
    "mrcjkb/haskell-snippets.nvim",
    dependencies = { "L3MON4D3/LuaSnip" },
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
    config = function()
      local haskell_snippets = require("haskell-snippets").all
      require("luasnip").add_snippets("haskell", haskell_snippets, { key = "haskell" })
    end,
  },
  {
    "mrcjkb/haskell-tools.nvim",
    version = "^2", -- Recommended
    lazy = false, -- This plugin is already lazy
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
    dependencies = {
      { "nvim-telescope/telescope.nvim", optional = true },
    },
    config = function()
      local ok, telescope = pcall(require, "telescope")
      if ok then
        telescope.load_extension("ht")
      end
      local lsp_zero = require('lsp-zero')

      lsp_zero.extend_lspconfig({
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      })

      ---
      -- Setup haskell LSP
      ---

      vim.g.haskell_tools = {
        hls = {
          capabilities = lsp_zero.get_capabilities()
        }
      }

      -- Autocmd that will actually be in charging of starting hls
      local hls_augroup = vim.api.nvim_create_augroup('haskell-lsp', {clear = true})
      vim.api.nvim_create_autocmd('FileType', {
        group = hls_augroup,
        pattern = {'haskell'},
        callback = function()
          ---
          -- Suggested keymaps from the quick setup section:
          -- https://github.com/mrcjkb/haskell-tools.nvim#quick-setup
          ---

          local ht = require('haskell-tools')
          -- haskell-language-server relies heavily on codeLenses,
          -- so auto-refresh (see advanced configuration) is enabled by default
          vim.keymap.set('n', '<space>ha', vim.lsp.codelens.run, {desc = "Auto-refresh"})
          -- Hoogle search for the type signature of the definition under the cursor
          vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, {desc = "Hoogle Search for the Type Signature"})
          -- Evaluate all code snippets
          vim.keymap.set('n', '<space>hc', ht.lsp.buf_eval_all, {desc = "Evaluate all Code Snippets"})
          -- Toggle a GHCi repl for the current package
          vim.keymap.set('n', '<leader>hr', ht.repl.toggle, {desc = "Toggle a GHCi Repl for Current Package"})
          -- Toggle a GHCi repl for the current buffer
          vim.keymap.set('n', '<leader>hf', function()
            ht.repl.toggle(vim.api.nvim_buf_get_name(0))
          end, {desc = "Toggle a GHCi Repl for Current Buffer"})
          vim.keymap.set('n', '<leader>hq', ht.repl.quit, {desc = "Quit the GHCi Repl"})
        end
      })
    end,
  },
}
