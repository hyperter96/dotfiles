return {
  setup = function(on_attach, capabilities)
    require("lspconfig").yamlls.setup(require("schema-companion").setup_client({
      -- your yaml language server configuration
      -- Have to add this for yamlls to understand that we support line folding
      on_attach = on_attach,
      capabilities = capabilities,
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
}
