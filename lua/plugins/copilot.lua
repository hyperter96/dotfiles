return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    enabled = true,
    config = function()
      vim.defer_fn(function()
        require("copilot").setup({
          panel = {
            enabled = false,
            auto_refresh = true,
            keymap = {
              jump_prev = "[[",
              jump_next = "]]",
              accept = "<CR>",
              refresh = "gr",
              open = "<c-CR>",
            },
          },
          suggestion = {
            enabled = true,
            auto_trigger = true,
            debounce = 75,
            keymap = {
              accept = "<c-;>",
              next = "<c-,>",
              prev = "<c-.>",
              dismiss = "<c-'>",
            },
          },
          filetypes = {
            yaml = false,
            help = false,
            gitcommit = false,
            gitrebase = false,
            hgcommit = false,
            svn = false,
            cvs = false,
            ["."] = false,
          },
          copilot_node_command = "node", -- Node version must be < 18
          server_opts_overrides = {
            trace = "verbose",
            settings = {
              advanced = {
                listCount = 10, -- #completions for panel
                inlineSuggestCount = 3, -- #completions for getCompletions
              },
            },
          },
        })
      end, 100)
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      debug = true, -- Enable debugging
      -- See Configuration section for rest
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
