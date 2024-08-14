return {
  {
    "nvim-neorg/neorg",
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.integrations.telescope"] = {},
        -- ["core.completion"] = {
        --   config = {
        --     engine = "nvim-cmp",
        --   },
        -- },
        -- ["core.integrations.nvim-cmp"] = {},
        -- ["core.integrations.image"] = {},
        -- ["core.latex.renderer"] = {},
      },
    },
    dependencies = { { "nvim-lua/plenary.nvim" }, { "nvim-neorg/neorg-telescope" } },
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "*", -- Pin Neorg to the latest stable release
    config = true,
  },
}
