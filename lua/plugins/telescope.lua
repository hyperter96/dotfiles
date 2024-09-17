local LazyVim = require("lazy.util")

return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    lazy = true,
    dependencies = {
      "andrew-george/telescope-themes",
      -- other dependencies
    },
    config = function()
      -- get builtin schemes list

      require("telescope").setup({
        extensions = {
          themes = {
            -- you can add regular telescope config
            -- that you want to apply on this picker only
            layout_config = {
              horizontal = {
                width = 0.8,
                height = 0.7,
              },
            },

            -- extension specific config

            -- (boolean) -> show/hide previewer window
            enable_previewer = true,

            -- (boolean) -> enable/disable live preview
            enable_live_preview = false,

            -- all builtin themes are ignored by default
            -- (list) -> provide table of theme names to overwrite builtins list
            ignore = { "default" },

            persist = {
              -- enable persisting last theme choice
              enabled = true,

              -- override path to file that execute colorscheme command
              path = vim.fn.stdpath("config") .. "/lua/colorscheme.lua",
            },
          },
        },
      })
    end,
  },
  {
    "debugloop/telescope-undo.nvim",
    dependencies = { -- note how they're inverted to above example
      {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    keys = {
      { -- lazy style key map
        "<leader>u",
        "<cmd>Telescope undo<cr>",
        desc = "undo history",
      },
    },
    opts = {
      -- don't use `defaults = { }` here, do this in the main telescope spec
      extensions = {
        undo = {
          side_by_side = true,
          layout_strategy = "vertical",
          layout_config = {
            preview_height = 0.8,
          },
        },
        -- no other extensions here, they can have their own spec too
      },
    },
    config = function(_, opts)
      -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
      -- configs for us. We won't use data, as everything is in it's own namespace (telescope
      -- defaults, as well as each extension).
      require("telescope").setup(opts)
      require("telescope").load_extension("undo")
    end,
  },
  {
    "dimaportenko/telescope-simulators.nvim",
    config = function()
      require("simulators").setup({
        android_emulator = true,
        apple_simulator = false,
      })
    end,
  },
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {},
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
  },
}
