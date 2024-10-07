return {
  setup = function(on_attach, capabilities)
    require("lspconfig").ltex.setup({
      on_attach = function(client, bufnr)
        vim.env.JAVA_HOME = vim.fs.find(function(name)
          return vim.startswith(name, "jdk-")
        end, { path = vim.fn.stdpath("data") .. "/mason/packages/ltex-ls/", type = "directory" })[1]
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
        on_attach(client, bufnr)
      end,
      capabilities = capabilities,
      settings = {
        ltex = {
          completionEnabled = true,
          language = "zh-CN",
        },
      },
      filetypes = {
        "typst",
        "bib",
        "gitcommit",
        "markdown",
        "org",
        "plaintex",
        "rst",
        "rnoweb",
        "tex",
        "pandoc",
        "quarto",
        "rmd",
      },
    })
  end,
}
