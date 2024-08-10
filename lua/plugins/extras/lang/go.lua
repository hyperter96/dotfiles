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
          { "<leader>G", group = "Go", icon = { icon = "󰟓 ", color = "blue" } },
        },
      },
    },
  },
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()

      -- Run gofmt + goimport on save
      local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require("go.format").goimport()
        end,
        group = format_sync_grp,
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    keys = {
      { "<leader>Gaj", "<cmd>GoAddTag<cr>", desc = "Add json tags" },
      { "<leader>Gam", "<cmd>GoAddTag mapstructure<cr>", desc = "Add mapstructure tags" },
      { "<leader>Gae", "<cmd>GoAddTag env<cr>", desc = "Add env tags" },
      { "<leader>Gay", "<cmd>GoAddTag yaml<cr>", desc = "Add YAML tags" },
      { "<leader>Gim", "<cmd>GoImplements<cr>", desc = "Find implementions of this method" },
      { "<leader>Gb", "<cmd>GoBuild %<cr>", desc = "Go Build Args" },
      { "<leader>Gc", "<cmd>GoCmt<cr>", desc = "Comment" },
      { "<leader>Gg", "<cmd>GoGenerate<cr>", desc = "Generate" },
      { "<leader>Gr", "<cmd>GoRun %<cr>", desc = "Go Run Args" },
      { "<leader>GT", "<cmd>GoModTidy<cr>", desc = "Tidy" },
      { "<leader>GM", "<cmd>GoMockGen<cr>", desc = "Generate Mocks" },
    },
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function(_, opts)
      require("dap-go").setup(opts)
      require("dap").set_log_level("TRACE")
    end,
  },
  {
    "fredrikaverpil/neotest-golang",
  },
  {
    "echasnovski/mini.icons",
    opts = {
      file = {
        [".go-version"] = { glyph = "", hl = "MiniIconsBlue" },
      },
      filetype = {
        gotmpl = { glyph = "󰟓", hl = "MiniIconsGrey" },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "fredrikaverpil/neotest-golang",
    },
    opts = {
      adapters = {
        ["neotest-golang"] = {
          -- Here we can set options for neotest-golang, e.g.
          -- go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
          dap_go_enabled = true, -- requires leoluz/nvim-dap-go
        },
      },
    },
  },
}
