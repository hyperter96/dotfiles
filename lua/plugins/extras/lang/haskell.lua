local wrap = require("utils.fn").wrap

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
      {
        "mfussenegger/nvim-dap-python",
        -- stylua: ignore
        keys = {
          { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
          { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class", ft = "python" },
        },
        config = function()
          if vim.fn.has("win32") == 1 then
            require("dap-python").setup(LazyVim.get_pkg_path("debugpy", "/venv/Scripts/pythonw.exe"))
          else
            require("dap-python").setup(LazyVim.get_pkg_path("debugpy", "/venv/bin/python"))
          end
        end,
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
          -- Load a File in the current Repl
          vim.keymap.set('n', '<leader>hl', wrap(ht.repl.load_file, vim.api.nvim_buf_get_name(0)), {desc = "Load a File in the Current Repl"})
          -- Reload a File in the current Repl
          vim.keymap.set('n', '<leader>hL', ht.repl.reload, {desc = "Reload a File in the Current Repl"})
          -- Toggle a GHCi repl for the current buffer
          vim.keymap.set('n', '<leader>hf', function()
            ht.repl.toggle(vim.api.nvim_buf_get_name(0))
          end, {desc = "Toggle a GHCi Repl for Current Buffer"})
          -- Quit the GHCi Repl
          vim.keymap.set('n', '<leader>hq', ht.repl.quit, {desc = "Quit the GHCi Repl"})
          -- Generate Project tags
          local opt = {refresh = true}
          vim.keymap.set('n', '<leader>hg', wrap(ht.tags.generate_project_tags, vim.api.nvim_buf_get_name(0), opt), { desc = "Generate Project Tags"})
          -- Generate Package tags
          vim.keymap.set('n', '<leader>hp', wrap(ht.tags.generate_package_tags, vim.api.nvim_buf_get_name(0)), { desc = "Generate Package Tags"})
          -- Query the Repl for info on the word under the cursor
          vim.keymap.set('n', '<leader>hQ', ht.repl.cword_info, { desc = "Query the Repl for Info on the Word"})
          -- Query the Repl for the type of word under the cursor
          vim.keymap.set('n', '<leader>ht', ht.repl.cword_type, {desc = "Query the Repl for the Type of Word"})
        end
      })
    end,
  },
}
