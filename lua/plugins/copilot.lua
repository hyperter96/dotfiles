return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "VeryLazy",
    enabled = false,
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
}
