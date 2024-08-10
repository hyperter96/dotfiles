return {
  -- add gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    event = "User ColorSchemeLoad",
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nightfox",
    },
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    event = "User ColorSchemeLoad",
    config = function()
      require("nightfox").load()
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    opts = { style = "moon" },
    event = "User ColorSchemeLoad",
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    event = "User ColorSchemeLoad",
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    event = "User ColorSchemeLoad",
  },
  {
    "ribru17/bamboo.nvim",
    lazy = false,
    priority = 1000,
    event = "User ColorSchemeLoad",
    config = function()
      require("bamboo").setup({
        -- optional configuration here
      })
    end,
  },
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    event = "User ColorSchemeLoad",
    opts = {
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        grug_far = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  },
}
