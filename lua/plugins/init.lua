return {
  { import = "lang.init" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "davidosomething/format-ts-errors.nvim" },
    },
    opts = {
      inlay_hints = {
        enabled = false,
      },
      diagnostics = { virtual_text = { prefix = "icons" } },
      capabilities = {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = false,
          },
        },
      },
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
  },
  { "WhoIsSethDaniel/mason-tool-installer.nvim" },
  { "VonHeikemen/lsp-zero.nvim", branch = "v4.x" },
  { "onsails/lspkind-nvim" }, -- vs-code like pictograms
  { "MunifTanjim/nui.nvim" },
  { "hrsh7th/nvim-cmp", event = "InsertEnter" },
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        cmp = { enabled = true },
      },
    },
  },
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
  { "guns/vim-sexp", ft = { "clojure" } },
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
  { import = "lsp.servers.jdtls" },
  { import = "lsp.servers.rustaceanvim" },
  { import = "lsp.servers.haskell-language-server" },

  -- coding
  { import = "lazyvim.plugins.extras.coding.neogen" },
  { import = "lazyvim.plugins.extras.coding.yanky" },
  { import = "lazyvim.plugins.extras.coding.mini-surround" },
  { import = "lazyvim.plugins.extras.coding.mini-comment" },

  -- editor
  { import = "lazyvim.plugins.extras.editor.leap" },
  { import = "lazyvim.plugins.extras.editor.navic" },
  { import = "lazyvim.plugins.extras.editor.illuminate" },
  { import = "lazyvim.plugins.extras.editor.telescope" },

  -- formatting
  { import = "lazyvim.plugins.extras.formatting.prettier" },

  -- lsp
  { import = "lazyvim.plugins.extras.lsp.none-ls" },
  -- lang
  { import = "lazyvim.plugins.extras.lang.git" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.toml" },
}
