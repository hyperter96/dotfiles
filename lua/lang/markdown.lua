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
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    opts = {
      file_types = { "markdown", "norg", "rmd", "org" },
      code = {
        -- Turn on / off code block & inline code rendering
        enabled = true,
        -- Turn on / off any sign column related rendering
        sign = false,
        -- Determines how code blocks & inline code are rendered:
        --  none: disables all rendering
        --  normal: adds highlight group to code blocks & inline code, adds padding to code blocks
        --  language: adds language icon to sign column if enabled and icon + name above code blocks
        --  full: normal + language
        style = "full",
        -- Determines where language icon is rendered:
        --  right: Right side of code block
        --  left: Left side of code block
        position = "left",
        -- An array of language names for which background highlighting will be disabled
        -- Likely because that language has background highlights itself
        disable_background = { "diff" },
        -- Amount of padding to add to the left of code blocks
        left_pad = 0,
        -- Amount of padding to add to the right of code blocks when width is 'block'
        right_pad = 0,
        -- Width of the code block background:
        --  block: width of the code block
        --  full: full width of the window
        width = "full",
        -- Determines how the top / bottom of code block are rendered:
        --  thick: use the same highlight as the code body
        --  thin: when lines are empty overlay the above & below icons
        border = "thin",
        -- Used above code blocks for thin border
        above = "▄",
        -- Used below code blocks for thin border
        below = "▀",
        -- Highlight for code blocks
        highlight = "RenderMarkdownCode",
        -- Highlight for inline code
        highlight_inline = "RenderMarkdownCodeInline",
      },
      heading = {
        -- Turn on / off heading icon & background rendering
        enabled = true,
        -- Turn on / off any sign column related rendering
        sign = true,
        -- Determines how the icon fills the available space:
        --  inline: underlying '#'s are concealed resulting in a left aligned icon
        --  overlay: result is left padded with spaces to hide any additional '#'
        position = "overlay",
        -- Replaces '#+' of 'atx_h._marker'
        -- The number of '#' in the heading determines the 'level'
        -- The 'level' is used to index into the array using a cycle
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        -- Added to the sign column if enabled
        -- The 'level' is used to index into the array using a cycle
        signs = { "󰫎 " },
        -- Width of the heading background:
        --  block: width of the heading text
        --  full: full width of the window
        width = "full",
        -- The 'level' is used to index into the array using a clamp
        -- Highlight for the heading icon and extends through the entire line
        backgrounds = {
          "RenderMarkdownH1Bg",
          "RenderMarkdownH2Bg",
          "RenderMarkdownH1Bg",
          "RenderMarkdownTodo",
          "RenderMarkdownH5Bg",
          "RenderMarkdownH6Bg",
        },
        -- The 'level' is used to index into the array using a clamp
        -- Highlight for the heading and sign icons
        foregrounds = {
          "RenderMarkdownH1",
          "RenderMarkdownH2",
          "RenderMarkdownH3",
          "RenderMarkdownH4",
          "RenderMarkdownH5",
          "RenderMarkdownH6",
        },
      },
    },
    ft = { "markdown", "norg", "rmd", "org" },
    config = function(_, opts)
      require("render-markdown").setup(opts)
      LazyVim.toggle.map("<leader>mR", {
        name = "Render Markdown",
        get = function()
          return require("render-markdown.state").enabled
        end,
        set = function(enabled)
          local m = require("render-markdown")
          if enabled then
            m.enable()
          else
            m.disable()
          end
        end,
      })
    end,
  },
  {
    "barreiroleo/ltex_extra.nvim",
    ft = { "markdown", "tex" },
    dependencies = { "neovim/nvim-lspconfig" },
    -- yes, you can use the opts field, just I'm showing the setup explicitly
    config = function()
      require("ltex_extra").setup({
        load_langs = { "zh-CN", "en-US" }, -- en-US as default
        -- boolean : whether to load dictionaries on startup
        init_check = true,
        -- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
        log_level = "none",
        server_opts = {
          filetypes = { "markdown", "tex", "lua" },
          on_attach = function(client, bufnr)
            -- your on_attach process
          end,
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
