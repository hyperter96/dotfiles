return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "yaml",
    })
  end,

  -- yaml schema support
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false, -- last release is way too old
  },
  {
    "cenk1cenk2/schema-companion.nvim",
    optional = false,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
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
  -- correctly setup lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "cenk1cenk2/schema-companion.nvim",
    },
    config = function()
      require("lspconfig").yamlls.setup(require("schema-companion").setup_client({
        -- your yaml language server configuration
        -- Have to add this for yamlls to understand that we support line folding
        capabilities = {
          textDocument = {
            foldingRange = {
              dynamicRegistration = false,
              lineFoldingOnly = true,
            },
          },
        },
        -- lazy-load schemastore when needed
        on_new_config = function(new_config)
          new_config.settings.yaml.schemas =
            vim.tbl_deep_extend("force", new_config.settings.yaml.schemas or {}, require("schemastore").yaml.schemas())
        end,
        settings = {
          redhat = { telemetry = { enabled = false } },
          yaml = {
            keyOrdering = false,
            format = {
              enable = true,
            },
            validate = true,
            completion = true,
            schemaStore = {
              -- Must disable built-in schemaStore support to use
              -- schemas from SchemaStore.nvim plugin
              enable = true,
              -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
              url = "https://www.schemastore.org/api/json/catalog.json",
            },
            schemas = {
              kubernetes = { "k8s**.yaml", "kube*/*.yaml" },
              ["~/.config/nvim/schemas/protolint.json"] = ".protolint.{yml,yaml}",
              ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
              ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
              ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = "azure-pipelines.yml",
              ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
              ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
              ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
              ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
              ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
              ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
              ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*gitlab-ci*.{yml,yaml}",
              ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
              ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
              ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
            },
          },
        },
      }))
    end,
    opts = {
      setup = {
        yamlls = function()
          -- Neovim < 0.10 does not have dynamic registration for formatting
          if vim.fn.has("nvim-0.10") == 0 then
            LazyVim.lsp.on_attach(function(client, _)
              client.server_capabilities.documentFormattingProvider = true
            end, "yamlls")
          end
        end,
      },
    },
  },
}
