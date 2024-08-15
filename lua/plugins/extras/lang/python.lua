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
          { "<leader>p", group = "Python", icon = { icon = "", color = "yellow" } },
        },
      },
    },
  },
  {
    "linux-cultist/venv-selector.nvim",
    branch = "regexp", -- Use this branch for the new version
    cmd = "VenvSelect",
    enabled = function()
      return LazyVim.has("telescope.nvim")
    end,
    opts = {
      settings = {
        options = {
          notify_user_on_venv_activation = true,
        },
      },
    },
    --  Call config for python files and load the cached venv automatically
    ft = "python",
    keys = { { "<leader>pv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" } },
  },
  {
    'MeanderingProgrammer/py-requirements.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      vim.keymap.set('n', '<leader>pu', require('py-requirements').upgrade, { silent = true, desc = 'Requirements: Upgrade' })
      vim.keymap.set('n', '<leader>pU', require('py-requirements').upgrade_all, { silent = true, desc = 'Requirements: Upgrade All' })
      vim.keymap.set('n', '<leader>pK', require('py-requirements').show_description, { silent = true, desc = 'Requirements: Show package description' })
      require('py-requirements').setup({
        -- Enabled by default if you do not use `nvim-cmp` set to false
        enable_cmp = true,
        -- Specify what file patterns to apply the plugin to
        -- For info on patterns, see :h pattern
        file_patterns = { 'requirements.txt' },
        -- For available options, see :h vim.lsp.util.open_floating_preview
        float_opts = { border = 'rounded' },
        filter = {
            -- If set to true pull only final release versions, this will ignore alpha,
            -- beta, release candidate, post release, and developmental release versions
            final_release = false,
            -- If set to true (default value) filter out yanked package versions
            yanked = true,
        },
      })
    end,
  },
  { 
    "stevanmilic/nvim-lspimport",
    config = function ()
      vim.keymap.set("n", "<leader>pi", require("lspimport").import, { noremap = true, desc = "Resolve Import" })
    end
  },
  {
    "GCBallesteros/NotebookNavigator.nvim",
    keys = {
      { "]h", function() require("notebook-navigator").move_cell "d" end },
      { "[h", function() require("notebook-navigator").move_cell "u" end },
      { "<leader>pX", "<cmd>lua require('notebook-navigator').run_cell()<cr>", desc = "NotebookNavigator: Run Cell" },
      { "<leader>px", "<cmd>lua require('notebook-navigator').run_and_move()<cr>", desc = "NotebookNavigator: Run & Move" },
    },
    dependencies = {
      "echasnovski/mini.comment",
      -- "hkupty/iron.nvim", -- repl provider
      "akinsho/toggleterm.nvim", -- alternative repl provider
      -- "benlubas/molten-nvim", -- alternative repl provider
      "anuvyklack/hydra.nvim",
    },
    event = "VeryLazy",
    config = function()
      require("notebook-navigator").setup({ activate_hydra_keys = "<leader>ph" })
    end,
  },
  {
    "echasnovski/mini.hipatterns",
    event = "VeryLazy",
    dependencies = { "GCBallesteros/NotebookNavigator.nvim" },
    opts = function()
      local opts = { highlighters = { cells = require("notebook-navigator").minihipatterns_spec } }
      return opts
    end,
  },
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    dependencies = { "GCBallesteros/NotebookNavigator.nvim" },
    opts = function()
      local opts = { custom_textobjects = { h = require("notebook-navigator").miniai_spec } }
      return opts
    end,
  },
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    build = ":UpdateRemotePlugins",
    init = function()
        -- this is an example, not a default. Please see the readme for more configuration options
        vim.g.molten_image_provider = "image.nvim"
        vim.g.molten_output_win_max_height = 20
    end,
  },
}
