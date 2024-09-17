return {
  setup = function(on_attach, _)
    require("lspconfig").gopls.setup({
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      on_attach = function(client, bufnr) -- on_attach for gopls
        on_attach(client, bufnr)
        -- your special on attach here
        if not client.server_capabilities.semanticTokensProvider then
          client.resolved_capabilities.document_formatting = false
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

        -- gopls
        vim.keymap.set("n", "<leader>Gi", "<cmd>GoInstallBinaries<cr>", { desc = "Install Binaries" })
        vim.keymap.set("n", "<leader>Gaa", "<cmd>GoAddTest<cr>", { desc = "Add Test" })
        vim.keymap.set("n", "<leader>GaA", "<cmd>GoAddAllTest<cr>", { desc = "Add All Tests" })
        vim.keymap.set("n", "<leader>Gae", "<cmd>GoAddExpTest<cr>", { desc = "Add Exported Tests" })
        vim.keymap.set("n", "<leader>Gf", "<cmd>GoGenerate %<cr>", { desc = "Generate File" })
        vim.keymap.set("n", "<leader>Gat", "<cmd>GoAddTag<cr>", { desc = "Add json tags" })
        vim.keymap.set("n", "<leader>Gay", "<cmd>GoAddTag yaml<cr>", { desc = "Add YAML tags" })
        vim.keymap.set(
          "n",
          "<leader>GI",
          "<cmd>GoImpl io.Reader<cr>",
          { desc = "Generate stubs for implementating an interface" }
        )

        -- test
        vim.keymap.set("n", "<leader>Gtu", "<cmd>GoTest<cr>", { desc = "Run Simple Unit Test" })
        vim.keymap.set("n", "<leader>Gtf", "<cmd>GoTestFile<cr>", { desc = "Run Test for Current File" })
        vim.keymap.set("n", "<leader>Gtn", "<cmd>GoTestFunc<cr>", { desc = "Run Test for Current Function" })
        vim.keymap.set("n", "<leader>Gtp", "<cmd>GoTestPkg<cr>", { desc = "Run Test for Current Package" })
        vim.keymap.set("n", "<leader>Gtc", "<cmd>GoCoverage<cr>", { desc = "Run Coverage Test" })

        -- Ginkgo
        vim.keymap.set("n", "<leader>GGr", "<cmd>Ginkgo run<cr>", { desc = "Run Ginkgo Test" })
        vim.keymap.set("n", "<leader>GGw", "<cmd>Ginkgo watch<cr>", { desc = "Watch Ginkgo Test" })
        vim.keymap.set("n", "<leader>GGb", "<cmd>Ginkgo bootstrap<cr>", { desc = "Bootstrap Ginkgo Test" })
        vim.keymap.set("n", "<leader>GGo", "<cmd>Ginkgo outline<cr>", { desc = "Outline Ginkgo Test" })
        vim.keymap.set("n", "<leader>GGB", "<cmd>Ginkgo Build<cr>", { desc = "Build Ginkgo Test" })

        -- debug
        vim.keymap.set("n", "<leader>GDd", "<cmd>GoDebug<cr>", { desc = "Start Debug Session" })
        vim.keymap.set("n", "<leader>GDc", "<cmd>GoDebug -c<cr>", { desc = "Compile Only" })
        vim.keymap.set("n", "<leader>GDt", "<cmd>GoDebug -t<cr>", { desc = "Start Debug Session for Test File" })
        vim.keymap.set("n", "<leader>GDR", "<cmd>GoDebug -R<cr>", { desc = "Restart Debug Session" })
        vim.keymap.set("n", "<leader>GDp", "<cmd>GoDebug -p<cr>", { desc = "Launch Package Test & Start Debug" })
        vim.keymap.set("n", "<leader>GDs", "<cmd>GoDebug -s<cr>", { desc = "Stop Debug Session" })
        vim.keymap.set("n", "<leader>GDb", "<cmd>GoBreakToggle<cr>", { desc = "Toggle the Break Point" })
        vim.keymap.set("n", "<leader>GDc", "<cmd>GoDbgContinue<cr>", { desc = "Continue Debug Session" })
        vim.keymap.set("n", "<leader>GDC", "<cmd>BreakCondition<cr>", { desc = "Conditional Break" })

        vim.keymap.set("n", "<leader>Gb", "<cmd>GoBuild %<cr>", { desc = "Go Build Args" })
        vim.keymap.set("n", "<leader>Gc", "<cmd>GoCmt<cr>", { desc = "Comment" })
        vim.keymap.set("n", "<leader>Gg", "<cmd>GoGenerate<cr>", { desc = "Generate" })
        vim.keymap.set("n", "<leader>Gr", "<cmd>GoRun %<cr>", { desc = "Go Run Args" })
        vim.keymap.set("n", "<leader>GT", "<cmd>GoModTidy<cr>", { desc = "Tidy" })
        vim.keymap.set("n", "<leader>GM", "<cmd>GoMockGen<cr>", { desc = "Generate Mocks" })
      end,
      settings = {
        gopls = {
          gofumpt = true,
          -- env = {
          --   GOPACKAGESDRIVER = "./tools/gopackagesdriver.sh",
          -- },
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
          -- hints = {
          --   assignVariableTypes = true,
          --   compositeLiteralFields = true,
          --   compositeLiteralTypes = true,
          --   constantValues = true,
          --   functionTypeParameters = true,
          --   parameterNames = true,
          --   rangeVariableTypes = true,
          -- },
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
          directoryFilters = {
            "-.git",
            "-.vscode",
            "-.idea",
            "-.vscode-test",
            "-node_modules",
            -- "-bazel-bin",
            -- "-bazel-out",
            -- "-bazel-testlogs",
            -- "-bazel-mypkg",
          },
          semanticTokens = true,
        },
      },
    })
  end,
}
