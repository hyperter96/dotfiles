return {
  {
    "nvim-neotest/neotest",
    optional = false,
    dependencies = {
      { "mrcjkb/neotest-haskell" },
    },
    opts = {
      adapters = {
        ["neotest-haskell"] = {},
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
  { "mrcjkb/neotest-haskell" },
  {
    "mrcjkb/haskell-tools.nvim",
    version = "^4", -- Recommended
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
    end,
  },
}
