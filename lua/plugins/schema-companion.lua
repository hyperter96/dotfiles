return {
  {
    "cenk1cenk2/schema-companion.nvim",
    optional = true,
    config = function()
      require("schema-companion").setup({
        -- if you have telescope you can register the extension
        enable_telescope = true,
        matchers = {
          -- add your matchers
          require("schema-companion.matchers.kubernetes").setup({ version = "master" }),
        },
        schemas = {
          {
            name = "Kubernetes master",
            uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master-standalone-strict/all.json",
          },
          {
            name = "Kubernetes v1.30",
            uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.30.3-standalone-strict/all.json",
          },
          {
            name = "Protolint",
            uri = "~/.config/nvim/schemas/protolint.json",
          },
        },
      })
      vim.keymap.set("n", "<leader>sy", function()
        return require("telescope").extensions.schema_companion.select_from_matching_schemas()
      end, { desc = "Select from Matching Schema" })
      vim.keymap.set("n", "<leader>sY", function()
        return require("telescope").extensions.schema_companion.select_schema()
      end, { desc = "Select from Schema" })
    end,
    -- keys = {
    --   {
    --     "n",
    --     "<leader>sy",
    --     function()
    --       return require("telescope").extensions.schema_companion.select_from_matching_schemas()
    --     end,
    --     { silent = true },
    --   },
    -- },
  },
}
