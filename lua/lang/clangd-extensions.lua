return {
  {
    "nvim-cmp",
    dependencies = {
      { "petertriho/cmp-git", opts = {} },
    },
    opts = function(_, opts)
      opts.sorting = {
        comparators = {},
      }
      table.insert(opts.sorting.comparators, 1, require("clangd_extensions.cmp_scores"))
      table.insert(opts.sources, { name = "git" })
    end,
  },
  {
    "p00f/clangd_extensions.nvim",
    lazy = true,
    config = function() end,
    opts = {
      inlay_hints = {
        inline = false,
      },
      ast = {
        --These require codicons (https://github.com/microsoft/vscode-codicons)
        role_icons = {
          type = "",
          declaration = "",
          expression = "",
          specifier = "",
          statement = "",
          ["template argument"] = "",
        },
        kind_icons = {
          Compound = "",
          Recovery = "",
          TranslationUnit = "",
          PackExpansion = "",
          TemplateTypeParm = "",
          TemplateTemplateParm = "",
          TemplateParamObject = "",
        },
      },
    },
  },
}
