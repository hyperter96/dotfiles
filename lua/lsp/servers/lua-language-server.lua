return {
  setup = function(on_attach, capabilities)
    require("lspconfig").lua_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          misc = {
            -- parameters = { "--loglevel=trace" },
          },
          -- hover = { expandAlias = false },
          type = {
            castNumberToInteger = true,
          },
          diagnostics = {
            disable = { "incomplete-signature-doc", "trailing-space", "missing-fields", "no-unknown" },
            -- enable = false,
            groupSeverity = {
              strong = "Warning",
              strict = "Warning",
            },
            groupFileStatus = {
              ["ambiguity"] = "Opened",
              ["await"] = "Opened",
              ["codestyle"] = "None",
              ["duplicate"] = "Opened",
              ["global"] = "Opened",
              ["luadoc"] = "Opened",
              ["redefined"] = "Opened",
              ["strict"] = "Opened",
              ["strong"] = "Opened",
              ["type-check"] = "Opened",
              ["unbalanced"] = "Opened",
              ["unused"] = "Opened",
            },
            neededFileStatus = {
              ["codestyle-check"] = "Any",
            },
            unusedLocalExclude = { "_*" },
          },
          format = {
            enable = true,
            defaultConfig = {
              indent_style = "space",
              indent_size = "2",
            },
          },
        },
      },
    })
  end,
}
