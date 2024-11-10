local LazyVim = require("lazyvim.util")
return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
    keys = {
      {
        "<leader>mT",
        ft = "markdown",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview Toggle",
      },
      {
        "<leader>mp",
        ft = "markdown",
        "<cmd>MarkdownPreview<cr>",
        desc = "Markdown Preview",
      },
      {
        "<leader>ms",
        ft = "markdown",
        "<cmd>MarkdownPreviewStop<cr>",
        desc = "Markdown Preview Stop",
      },
    },
    config = function()
      vim.cmd([[do FileType]])
      vim.cmd([[
        function OpenMarkdownPreview (url)
          let cmd = "google-chrome-stable --no-sandbox --disable-gpu --new-window " . shellescape(a:url) . " &"
          silent call system(cmd)
        endfunction
      ]])
      vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
    end,
  },
  {
    "barreiroleo/ltex_extra.nvim",
    ft = { "markdown", "tex" },
    config = function()
      require("ltex_extra").setup({
        load_langs = { "zh-CN", "en-US" }, -- en-US as default
        -- boolean : whether to load dictionaries on startup
        init_check = true,
        -- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
        log_level = "none",
        server_opts = {
          filetypes = { "markdown", "tex", "lua" },
          on_attach = function(client, bufnr) end,
          settings = {
            ltex = {
              enabled = { "markdown", "tex", "lua" },
              language = "zh-CN",
              java = {
                path = "/usr/lib/jvm/java-21-openjdk-amd64",
              },
              setenceCacheSize = 2000,
              additionalRules = {
                enablePickyRules = true,
                motherTongue = "zh-CN",
                languageModel = "~/models/ngrams/",
              },
              trace = { server = "verbose" },
              disabledRules = {},
              hiddenFalsePositives = {},
            },
          },
        },
      })
    end,
  },
  {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = { -- Example mapping to toggle outline
      { "<leader>mo", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    opts = {
      symbol_folding = {
        -- Unfold entire symbol tree by default with false, otherwise enter a
        -- number starting from 1
        autofold_depth = false,
        -- autofold_depth = 1,
      },
    },
  },
  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup()
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },
}
