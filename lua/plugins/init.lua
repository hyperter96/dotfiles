return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        -- Only load the lazyvim library when the `LazyVim` global is found
        { path = "LazyVim", words = { "LazyVim" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true },
  { import = "lang.init" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "davidosomething/format-ts-errors.nvim" },
  {
    "dmmulroy/ts-error-translator.nvim",
    config = true,
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact", "vue" },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false,
      },
      document_highlight = { enabled = false },
      diagnostics = { virtual_text = { prefix = "icons" } },
      setup = {
        hls = function()
          return true
        end,
        jdtls = function()
          -- this will disable LazyVim from setting up jdtls automatically
          return true
        end,
        -- tsserver = function()
        --   return true
        -- end,
        clangd = function(_, opts)
          local clangd_ext_opts = LazyVim.opts("clangd_extensions.nvim")
          require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts }))
          return false
        end,
      },
    },
    config = function()
      require("lsp")
    end,
  },
  { "WhoIsSethDaniel/mason-tool-installer.nvim" },
  { "VonHeikemen/lsp-zero.nvim", branch = "v4.x" },
  { "onsails/lspkind-nvim" }, -- vs-code like pictograms
  { "MunifTanjim/nui.nvim" },
  { "hrsh7th/nvim-cmp", event = "InsertEnter", lazy = true },
  { "Saecki/crates.nvim", event = { "BufRead Cargo.toml" } },
  { "hrsh7th/cmp-nvim-lsp-signature-help" },
  { "hrsh7th/cmp-nvim-lua", ft = { "lua" } },
  { "hrsh7th/cmp-nvim-lsp" },
  { "folke/neodev.nvim" },
  { "L3MON4D3/LuaSnip" }, -- snippet engine
  { "saadparwaiz1/cmp_luasnip" }, -- for autocompletion
  { "honza/vim-snippets" }, -- useful snippets
  { "hrsh7th/cmp-buffer" }, -- source for text in buffer
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/cmp-path" }, -- source for file system paths
  { "nvim-lua/plenary.nvim" },
  { "lukas-reineke/lsp-format.nvim" },
  { "tpope/vim-repeat" },
  { "tpope/vim-surround" },
  { "tpope/vim-rhubarb" },
  { "tpope/vim-eunuch" },
  { "b0o/incline.nvim", event = "VeryLazy" },
  { "romainl/vim-cool" },
  { "nvim-tree/nvim-web-devicons" },
  { "lambdalisue/glyph-palette.vim" },
  { "AndrewRadev/tagalong.vim" },
  { "tpope/vim-abolish" },
  { "djoshea/vim-autoread" },
  { "jbyuki/one-small-step-for-vimkind" },
  { "grapp-dev/nui-components.nvim" },
  { "folke/twilight.nvim" },
  { "MunifTanjim/nui.nvim", lazy = true },
  { "akinsho/toggleterm.nvim", version = "*", config = true },
  { "junegunn/fzf.vim" },
  { "sindrets/diffview.nvim" },
  { "kevinhwang91/promise-async" },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  { "m4xshen/hardtime.nvim", optional = true, opts = {} },
  { "b0o/SchemaStore.nvim", lazy = true, version = false }, -- last release is way too old
  { "nvimdev/lspsaga.nvim", optional = false },
  -- lsp for java, rust, haskell
  { "mfussenegger/nvim-jdtls", ft = { "java" } },
  { "mrcjkb/rustaceanvim", version = "^4", ft = { "rust" } },
  {
    "mrcjkb/haskell-tools.nvim",
    version = "^2",
    lazy = false,
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
  },
  {
    "luc-tielen/telescope_hoogle",
    lazy = true,
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
  },
  { "mrcjkb/haskell-snippets.nvim", ft = { "haskell", "lhaskell", "cabal", "cabalproject" } },
  -- lsp
  { import = "lazyvim.plugins.extras.lsp.none-ls" },
}
