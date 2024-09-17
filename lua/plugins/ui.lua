local LazyVim = require("lazyvim.util")
return {
  {
    "folke/noice.nvim",
    optional = true,
    opts = function(_, opts)
      opts.debug = false
      opts.routes = opts.routes or {}
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })

      table.insert(opts.routes, 1, {
        filter = {
          ["not"] = {
            event = "lsp",
            kind = "progress",
          },
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })
      return opts
    end,
  },
  {
    "folke/noice.nvim",
    optional = false,
    event = "VeryLazy",
    opts = {
      lsp = {
        hover = {
          enabled = false,
        },
        signature = {
          enabled = false,
        },
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  },
  {
    "b0o/incline.nvim",
    config = function()
      require("incline").setup()
    end,
    -- Optional: Lazy load Incline
    event = "VeryLazy",
  },
  {
    "topaxi/gh-actions.nvim",
    keys = {
      { "<leader>gH", "<cmd>GhActions<cr>", desc = "Open Github Actions" },
    },
    -- optional, you can also install and use `yq` instead.
    build = "make",
    optional = true,
  },
}
