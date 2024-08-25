local util = require("lspconfig.util")

local root_files = {
  ".clangd",
  ".clang-tidy",
  ".clang-format",
  "compile_commands.json",
  "compile_flags.txt",
  "build.sh", -- buildProject
  "configure.ac", -- AutoTools
  ".gitignore",
}

local function rDir(fname)
  return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
end

return {
  {
    "ray-x/navigator.lua",
    optional = false,
    opts = {
      setup = {
        hls = function()
          return true
        end,
        tsserver = function()
          return true
        end,
        clangd = function(_, opts)
          local clangd_ext_opts = LazyVim.opts("clangd_extensions.nvim")
          require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts }))
          return false
        end,
      },
    },
    dependencies = {
      { "ray-x/guihua.lua", build = "cd lua/fzy && make" },
      { "neovim/nvim-lspconfig" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "NTBBloodbath/zig-tools.nvim" },
      { "Civitasv/cmake-tools.nvim"},
      { "ziglang/zig.vim" },
    },
    config = function()
      local lsp_zero = require("lsp-zero")
      -- lsp_attach is where you enable features that only work
      -- if there is a language server active in the file
      local lsp_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentFormattingRangeProvider = false
      end
      lsp_zero.format_on_save({
        format_opts = {
          async = false,
          timeout_ms = 10000,
        },
        servers = {
          ['tsserver'] = {'javascript', 'typescript'},
          ['clangd'] = {'cpp'},
          ['gopls'] = {'go'},
        }
      })
      lsp_zero.extend_lspconfig({
        sign_text = true,
        lsp_attach = lsp_attach,
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      require("navigator").setup({
        default_mapping = false,
        on_attach = lsp_attach,
        mason = false,
        transparency = 50,
        keymaps = {
          {key = '<F7>', func = require("navigator.dochighlight").hi_symbol, desc = 'Highlight Symbols'},
          {key = '<leader>ls', func = require('navigator.symbols').side_panel, desc = "Toggle the Outline by Sidebar"},
          {key = '<leader>lG', func = require('navigator.lspclient.config').open_lsp_log, desc = "Open Lsp Log"},
          {key = '<leader>lc', func = vim.lsp.buf.declaration, desc = "Goto Declaration"},
          { key = '<leader>lw',            func = require('navigator.diagnostics').show_diagnostics,                    desc = 'Show Diagnostics' },
          { key = '<leader>lW',            func = require('navigator.diagnostics').show_buf_diagnostics,                desc = 'Show Buf Diagnostics' },
          { key = '<Leader>lT',    func = require('navigator.diagnostics').toggle_diagnostics,                  desc = 'Toggle Diagnostics' },
          { key = '<Leader>lb', func = require('navigator.treesitter').buf_ts, desc = 'Show Treesitter Symbols' },
          { key = '<leader>la', func = require('navigator.reference').async_ref, desc = 'Show References' },
          { key = '<leader>le', func = require('navigator.hierarchy').calltree, desc = 'Calltree' },
          -- { key = '<leader>lp', func = require('navigator.definition').definition_preview, desc = 'Definition Preview'}
          
        },
        lsp = {
          hover = {
            enable = true,
            go = function()
              local w = vim.fn.expand('<cWORD>')
              vim.cmd('GoDoc ' .. w)
            end,
            default = function()
              -- fallback apply to all file types not been specified above
              local w = vim.fn.expand('<cWORD>')
              vim.lsp.buf.workspace_symbol(w)
            end,
          },
          disable_lsp = {'denols', 'rust_analyzer'},
          lua_ls = {
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
          },
          zls = {
            on_attach = function(client, bufnr)
              -- zig keymap
              vim.keymap.set("n", "<leader>zr", "<cmd>Zig run<cr>", { desc = "Run Zig Current File" })
              vim.keymap.set("n", "<leader>zb", "<cmd>Zig build<cr>", { desc = "Build Current Project" })
              vim.keymap.set("n", "<leader>zc", "<cmd>Zig check<cr>", { desc = "Check All Current Project Files" })
              vim.keymap.set("n", "<leader>zt", "<cmd>Zig task<cr>", { desc = "Run a build.zig Task" })
            end,
            cmd = { "zls" },
            filetypes = { "zig", "zon" },
            root_dir = util.root_pattern("zls.json", "build.zig"),
          },
          clangd = {
            on_attach = function(client, bufnr)
              
              -- clangd
              vim.keymap.set(
                "n",
                "<leader>Ch",
                "<cmd>ClangdSwitchSourceHeader<cr>",
                { desc = "Switch Source/Header (C/C++)" }
              )
              vim.keymap.set("n", "<leader>Cr", "<cmd>CMakeRun<cr>", { desc = "Run Selected Launchable Target" })
              vim.keymap.set(
                "n",
                "<leader>Cl",
                "<cmd>CMakeLauchArgs<cr>",
                { desc = "CMakeRun with Additional Argument" }
              )
              vim.keymap.set("n", "<leader>Cc", "<cmd>CMakeClean<cr>", { desc = "Clean All Targets & Deps" })
              vim.keymap.set("n", "<leader>Cq", "<cmd>CMakeClose<cr>", { desc = "Close CMake Executor/Runner Window" })
              vim.keymap.set(
                "n",
                "<leader>Cb",
                "<cmd>CMakeBuild<cr>",
                { desc = "Compile Targets with Pre-build System" }
              )
              vim.keymap.set("n", "<leader>Cg", "<cmd>CMakeGenerate<cr>", { desc = "Generate Native Build System" })
              vim.keymap.set("n", "<leader>Cd", "<cmd>CMakeDebug<cr>", { desc = "Debug Selected Launchable Target" })
            end,
            capabilities = {
              offsetEncoding = { "utf-16" },
            },
            root_dir = function(fname)
              return util.root_pattern(
                "Makefile",
                "configure.ac",
                "configure.in",
                "config.h.in",
                "meson.build",
                "meson_options.txt",
                "build.ninja"
              )(fname) or util.root_pattern(
                "compile_commands.json",
                "compile_flags.txt"
              )(fname) or util.find_git_ancestor(fname)
            end,
            cmd = {
              "clangd",
              "--background-index",
              "--clang-tidy",
              "--header-insertion=iwyu",
              "--completion-style=detailed",
              "--function-arg-placeholders",
              "--fallback-style=llvm",
            },
            flags = {allow_incremental_sync = true, debounce_text_changes = 500},
            init_options = {
              usePlaceholders = true,
              completeUnimported = true,
              clangdFileStatus = true,
            },
          },
          gopls = {
            filetypes = { "go", "gomod", "gowork", "gotmpl" },
            on_attach = function(client, bufnr) -- on_attach for gopls
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
              vim.keymap.set('n', "<leader>Gtu", "<cmd>GoTest<cr>", {desc = "Run Simple Unit Test"})
              vim.keymap.set('n', "<leader>Gtf", "<cmd>GoTestFile<cr>", {desc = "Run Test for Current File"})
              vim.keymap.set('n', "<leader>Gtn", "<cmd>GoTestFunc<cr>", {desc = "Run Test for Current Function"})
              vim.keymap.set('n', "<leader>Gtp", "<cmd>GoTestPkg<cr>", {desc = "Run Test for Current Package"})
              vim.keymap.set('n', "<leader>Gtc", "<cmd>GoCoverage<cr>", {desc = "Run Coverage Test"})

              -- Ginkgo
              vim.keymap.set('n', "<leader>GGr", "<cmd>Ginkgo run<cr>", {desc = "Run Ginkgo Test"})
              vim.keymap.set("n", "<leader>GGw", "<cmd>Ginkgo watch<cr>", {desc = "Watch Ginkgo Test"})
              vim.keymap.set("n", "<leader>GGb", "<cmd>Ginkgo bootstrap<cr>", {desc = "Bootstrap Ginkgo Test"})
              vim.keymap.set('n', "<leader>GGo", "<cmd>Ginkgo outline<cr>", {desc = "Outline Ginkgo Test"})
              vim.keymap.set('n', "<leader>GGB", "<cmd>Ginkgo Build<cr>", {desc = "Build Ginkgo Test"})

              -- debug
              vim.keymap.set('n', "<leader>GDd", "<cmd>GoDebug<cr>", {desc = "Start Debug Session"})
              vim.keymap.set('n', "<leader>GDc", "<cmd>GoDebug -c<cr>", {desc = "Compile Only"})
              vim.keymap.set('n', "<leader>GDt", "<cmd>GoDebug -t<cr>", {desc = "Start Debug Session for Test File"})
              vim.keymap.set('n', "<leader>GDR", "<cmd>GoDebug -R<cr>", {desc = "Restart Debug Session"})
              vim.keymap.set("n", "<leader>GDp", "<cmd>GoDebug -p<cr>", {desc = "Launch Package Test & Start Debug"})
              vim.keymap.set('n', "<leader>GDs", "<cmd>GoDebug -s<cr>", {desc = "Stop Debug Session"})
              vim.keymap.set('n', "<leader>GDb", "<cmd>GoBreakToggle<cr>", {desc = "Toggle the Break Point"})
              vim.keymap.set("n", "<leader>GDc", "<cmd>GoDbgContinue<cr>", {desc = "Continue Debug Session"})
              vim.keymap.set("n", "<leader>GDC", "<cmd>BreakCondition<cr>", {desc = "Conditional Break"})

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
          },
          
          tsserver = {
            root_dir = function(...)
              return util.root_pattern(".git", "package.json", "jsconfig.json", "tsconfig.json")(...)
            end,
            single_file_support = true,
            settings = {
              typescript = {
                inlayHints = {
                  includeInlayParameterNameHints = "literal",
                  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayVariableTypeHints = false,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayEnumMemberValueHints = true,
                },
              },
              javascript = {
                inlayHints = {
                  includeInlayParameterNameHints = "all",
                  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayVariableTypeHints = true,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayEnumMemberValueHints = true,
                },
              },
            },
          },
          tailwindcss = {
            root_dir = function(...)
              return util.root_pattern(".git")(...)
            end,
          },
          texlab = {
            cmd = {
              "texlab",
            },
            filetypes = { "tex", "plaintex", "bib" },
            root_dir = rDir(fname),
            single_file_support = true,
            flags = {
              allow_incremental_sync = false,
            },
            settings = {
              texlab = {
                rootDirectory = rDir(fname),
                build = {
                  args = {
                    "-src",
                    "-silent",
                    "-output-directory=build",
                    "-interaction=nonstopmode",
                    "-synctex=1",
                    "%f",
                  },
                  executable = "latexmk",
                  forwardSearchAfter = true,
                  onSave = false,
                },
                auxDirectory = "build",
                --[[ forwardSearch = { ]]
                --[[ 	executable = "pdflatex", ]]
                --[[ 	args = { ]]
                --[[ 		" -synctex=1", ]]
                --[[ 		"-interaction=nonstopmode", ]]
                --[[ 		"-output-directory=.build", ]]
                --[[ 		"%f", ]]
                --[[ 	} ]]
                --[[ }, ]]
                forwardSearch = {
                  args = { "--synctex-forward", "%l:1:%f", "%p" },
                  executable = "zathura",
                },
                chktex = {
                  onOpenAndSave = true,
                  onEdit = false,
                },
                diagnosticsDelay = 300,
                diagnostic = {
                  allowedPatterns = {},
                  ignoredPatterns = {},
                },
                formatterLineLength = 125,
                bibtexFormatter = "texlab",
                latexFormatter = "latexindent",
                latexindent = {
                  modifyLineBreaks = true,
                },
              },
            },
          },
          
          servers = {'cmake', 'ltex', 'ruff', 'ruff_lsp', 'autotools_ls', 'pyright'},
        },
      })
      -- vim.keymap.set("n", "<leader>ls", "<cmd>LspSymbols<cr>", { desc = "Toggle the Outline by Sidebar" })
      -- vim.keymap.set("n", "<F7>", require("navigator.dochighlight").hi_symbol, { desc = "Highlight Symbols" })
    end,
  },
}
