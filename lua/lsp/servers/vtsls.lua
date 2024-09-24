local utils = require("utils")
return {
  setup = function(on_attach, capabilities)
    local lspconfig = require("lspconfig")
    lspconfig.vtsls.setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        utils.move_to_file_refactor(client, bufnr)
        on_attach(client, bufnr)
      end,
      init_options = {
        plugins = {
          -- {
          --   name = "@vue/typescript-plugin",
          --   location = vim.fn.expand("$HOME")
          --     .. "/.local/share/mise/installs/node/20.13.1/lib/node_modules/@vue/typescript-plugin",
          --   languages = { "javascript", "typescript", "vue" },
          -- },
          {
            name = "@vue/typescript-plugin",
            location = utils.get_pkg_path("vue-language-server", "/node_modules/@vue/language-server"),
            languages = { "vue" },
            configNamespace = "typescript",
            enableForWorkspaceTypeScriptVersions = true,
          },
        },
        documentFeatures = {
          documentColor = true,
        },
        languageFeatures = {
          semanticTokens = true,
        },
      },
      filetypes = {
        "typescript",
        "javascript",
        "javascriptreact",
        "typescriptreact",
        "vue",
      },
      settings = {
        complete_function_calls = true,
        vtsls = {
          tsserver = {
            globalOptions = {
              {
                name = "@vue/typescript-plugin",
                location = utils.get_pkg_path("vue-language-server", "/node_modules/@vue/language-server"),
                languages = { "vue" },
                configNamespace = "typescript",
                enableForWorkspaceTypeScriptVersions = true,
              },
            },
          },
          enableMoveToFileCodeAction = true,
          autoUseWorkspaceTsdk = true,
          experimental = {
            completion = {
              enableServerSideFuzzyMatch = true,
            },
          },
        },
        typescript = {
          updateImportsOnFileMove = { enabled = "always" },
          suggest = {
            completeFunctionCalls = true,
          },
          inlayHints = {
            parameterNames = { enabled = "literals" },
            parameterTypes = { enabled = true },
            variableTypes = { enabled = true },
            propertyDeclarationTypes = { enabled = true },
            functionLikeReturnTypes = { enabled = true },
            enumMemberValues = { enabled = true },
          },
          format = {
            indentSize = vim.o.shiftwidth,
            convertTabsToSpaces = vim.o.expandtab,
            tabSize = vim.o.tabstop,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true, -- false
            includeInlayVariableTypeHintsWhenTypeMatchesName = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
          format = {
            indentSize = vim.o.shiftwidth,
            convertTabsToSpaces = vim.o.expandtab,
            tabSize = vim.o.tabstop,
          },
        },
        completions = {
          completeFunctionCalls = true,
        },
      },
    })
    lspconfig.volar.setup({
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        on_attach(client, bufnr)
      end,
      capabilities = capabilities,
      filetypes = { "vue" },
      -- filetypes = has_vue and { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" } or { "vue" },
      init_options = {
        vue = {
          hybridMode = false,
        },
        -- typescript = {
        --   tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
        -- },
      },
      documentFeatures = {
        documentColor = true,
      },
      languageFeatures = {
        semanticTokens = true,
      },
      settings = {
        completeFunctionCalls = true,
      },
    })
  end,
}
