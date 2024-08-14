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
          { "<leader>Ga", group = "Add tags", icon = { icon = "󰟓 ", color = "blue" } },
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
    -- keys = {
    --   { "<leader>Gaj", "<cmd>GoAddTag<cr>", desc = "Add json tags" },
    --   { "<leader>Gam", "<cmd>GoAddTag mapstructure<cr>", desc = "Add mapstructure tags" },
    --   { "<leader>Gae", "<cmd>GoAddTag env<cr>", desc = "Add env tags" },
    --   { "<leader>Gay", "<cmd>GoAddTag yaml<cr>", desc = "Add YAML tags" },
    --   { "<leader>Gim", "<cmd>GoImplements<cr>", desc = "Find implementions of this method" },
    --   { "<leader>Gb", "<cmd>GoBuild %<cr>", desc = "Go Build Args" },
    --   { "<leader>Gc", "<cmd>GoCmt<cr>", desc = "Comment" },
    --   { "<leader>Gg", "<cmd>GoGenerate<cr>", desc = "Generate" },
    --   { "<leader>Gr", "<cmd>GoRun %<cr>", desc = "Go Run Args" },
    --   { "<leader>GT", "<cmd>GoModTidy<cr>", desc = "Tidy" },
    --   { "<leader>GM", "<cmd>GoMockGen<cr>", desc = "Generate Mocks" },
    -- },
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
    "neovim/nvim-lspconfig",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
    },
    config = function()
      local lsp_zero = require("lsp-zero")

      -- lsp_attach is where you enable features that only work
      -- if there is a language server active in the file
      local lsp_attach = function(client, bufnr)
        local opts = { buffer = bufnr }

        vim.keymap.set("n", "<leader>Gi", "<cmd>GoInstallDeps<cr>", { desc = "Install Dependencies" })
        vim.keymap.set("n", "<leader>Gt", "<cmd>GoTestAdd<cr>", { desc = "Add Test" })
        vim.keymap.set("n", "<leader>GA", "<cmd>GoTestAll<cr>", { desc = "Add All Tests" })
        vim.keymap.set("n", "<leader>Ge", "<cmd>GoTestExp<cr>", { desc = "Add Exported Tests" })
        vim.keymap.set("n", "<leader>Gf", "<cmd>GoGenerate %<cr>", { desc = "Generate File" })
        vim.keymap.set("n", "<leader>Gaj", "<cmd>GoAddTag<cr>", { desc = "Add json tags" })
        vim.keymap.set("n", "<leader>Gam", "<cmd>GoAddTag mapstructure<cr>", { desc = "Add mapstructure tags" })
        vim.keymap.set("n", "<leader>Gae", "<cmd>GoAddTag env<cr>", { desc = "Add env tags" })
        vim.keymap.set("n", "<leader>Gay", "<cmd>GoAddTag yaml<cr>", { desc = "Add YAML tags" })
        vim.keymap.set("n", "<leader>GI", "<cmd>GoImplements<cr>", { desc = "Find Implementations of this method" })
        vim.keymap.set("n", "<leader>Gb", "<cmd>GoBuild %<cr>", { desc = "Go Build Args" })
        vim.keymap.set("n", "<leader>Gc", "<cmd>GoCmt<cr>", { desc = "Comment" })
        vim.keymap.set("n", "<leader>Gg", "<cmd>GoGenerate<cr>", { desc = "Generate" })
        vim.keymap.set("n", "<leader>Gr", "<cmd>GoRun %<cr>", { desc = "Go Run Args" })
        vim.keymap.set("n", "<leader>GT", "<cmd>GoModTidy<cr>", { desc = "Tidy" })
        vim.keymap.set("n", "<leader>GM", "<cmd>GoMockGen<cr>", { desc = "Generate Mocks" })
      end

      lsp_zero.extend_lspconfig({
        sign_text = true,
        lsp_attach = lsp_attach,
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      -- These are just examples. Replace them with the language
      -- servers you have installed in your system
      require("lspconfig").gopls.setup({
        on_attach = function(client, bufnr)
          if not client.server_capabilities.semanticTokensProvider then
            local semantic = client.config.capabilities.textDocument.semanticTokens
            if semantic ~= nil then
              client.server_capabilities.semanticTokensProvider = {
                full = true,
                legend = {
                  tokenTypes = semantic.tokenTypes,
                  tokenModifiers = semantic.tokenModifiers,
                },
                range = true,
              }
            end
          end
        end,
        settings = {
          gopls = {
            gofumpt = true,
            codelenses = {
              gc_details = false,
              generate = true,
              regenerate_cgo = true,
              run_govulncheck = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            analyses = {
              fieldalignment = true,
              nilness = true,
              unusedparams = true,
              unusedwrite = true,
              useany = true,
            },
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
            semanticTokens = true,
          },
        },
      })
    end,
  },
}
