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
          { "<leader>T", group = "TypeScript", icon = { icon = "󰛦", color = "yellow" } },
        },
      },
    },
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("typescript-tools").setup({
        on_attach = function ()
          vim.keymap.set("n", "<leader>To", "<cmd>TSToolsOrganizeImports<cr>", { desc = "Sort & Remove Unused Imports" })
          vim.keymap.set("n", "<leader>Ts", "<cmd>TSToolsSortImports<cr>", {desc = "Sort Imports"})
          vim.keymap.set("n", "<leader>TR", "<cmd>TSToolsRemoveUnusedImports<cr>", {desc = "Removes Unused Imports"})
          vim.keymap.set("n", "<leader>Tr", "<cmd>TSToolsRemoveUnused<cr>", {desc = "Removes All Unused Statements"})
          vim.keymap.set("n", "<leader>Ta", "<cmd>TSToolsAddMissingImports<cr>", {desc = "Add Imports that is Missing"})
          vim.keymap.set("n", "<leader>Tx", "<cmd>TSToolsFixAll<cr>", {desc = "Fixes All Fixable Errors"})
          vim.keymap.set("n", "<leader>Tg", "<cmd>TSToolsGoToSourceDefinition<cr>", {desc = "GoTo Source Definition"})
          vim.keymap.set("n", "<leader>Tf", "<cmd>TSToolsFileReferences<cr>", {desc = "Find Files that Reference the Current File"})
        end,
        settings = {
          tsserver_file_preferences = {
            includeInlayParameterNameHints = "all",
            includeCompletionsForModuleExports = true,
            quotePreference = "auto",
          },
          tsserver_format_options = {
            allowIncompleteCompletions = false,
            allowRenameOfImportPath = false,
          },
        },
      })
    end,
  },
  {
    "echasnovski/mini.icons",
    opts = {
      file = {
        [".eslintrc.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        [".node-version"] = { glyph = "", hl = "MiniIconsGreen" },
        [".prettierrc"] = { glyph = "", hl = "MiniIconsPurple" },
        [".yarnrc.yml"] = { glyph = "", hl = "MiniIconsBlue" },
        ["eslint.config.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        ["package.json"] = { glyph = "", hl = "MiniIconsGreen" },
        ["tsconfig.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["tsconfig.build.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["yarn.lock"] = { glyph = "", hl = "MiniIconsBlue" },
      },
    },
  },
}
