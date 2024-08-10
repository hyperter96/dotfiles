return {
  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = true,
      },
      diagnostics = { virtual_text = { prefix = "icons" } },
      capabilities = {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = false,
          },
        },
      },
      setup = {
        hls = function()
          return true
        end,
        tsserver = function()
          return true
        end,
        vtsls = function(_, opts)
          LazyVim.lsp.on_attach(function(client, buffer)
            client.commands["_typescript.moveToFileRefactoring"] = function(command, ctx)
              ---@type string, string, lsp.Range
              local action, uri, range = unpack(command.arguments)

              local function move(newf)
                client.request("workspace/executeCommand", {
                  command = command.command,
                  arguments = { action, uri, range, newf },
                })
              end

              local fname = vim.uri_to_fname(uri)
              client.request("workspace/executeCommand", {
                command = "typescript.tsserverRequest",
                arguments = {
                  "getMoveToRefactoringFileSuggestions",
                  {
                    file = fname,
                    startLine = range.start.line + 1,
                    startOffset = range.start.character + 1,
                    endLine = range["end"].line + 1,
                    endOffset = range["end"].character + 1,
                  },
                },
              }, function(_, result)
                ---@type string[]
                local files = result.body.files
                table.insert(files, 1, "Enter new path...")
                vim.ui.select(files, {
                  prompt = "Select move destination:",
                  format_item = function(f)
                    return vim.fn.fnamemodify(f, ":~:.")
                  end,
                }, function(f)
                  if f and f:find("^Enter new path") then
                    vim.ui.input({
                      prompt = "Enter move destination:",
                      default = vim.fn.fnamemodify(fname, ":h") .. "/",
                      completion = "file",
                    }, function(newf)
                      return newf and move(newf)
                    end)
                  elseif f then
                    move(f)
                  end
                end)
              end)
            end
          end, "vtsls")
          -- copy typescript settings to javascript
          opts.settings.javascript =
            vim.tbl_deep_extend("force", {}, opts.settings.typescript, opts.settings.javascript or {})
        end,
        gopls = function(_, opts)
          -- workaround for gopls not supporting semanticTokensProvider
          LazyVim.lsp.on_attach(function(client, _)
            if not client.server_capabilities.semanticTokensProvider then
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
          end, "gopls")
          -- end workaround
        end,
        rust_analyzer = function()
          return true
        end,
        clangd = function(_, opts)
          local clangd_ext_opts = LazyVim.opts("clangd_extensions.nvim")
          require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts }))
          return false
        end,
      },
      servers = {
        neocmake = {},
        tsserver = {
          enabled = false,
        },
        vtsls = {
          -- explicitly add default filetypes, so that we can extend
          -- them in related extras
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
          },
          settings = {
            complete_function_calls = true,
            vtsls = {
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
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
            },
          },
          keys = {
            {
              "tD",
              function()
                local params = vim.lsp.util.make_position_params()
                LazyVim.lsp.execute({
                  command = "typescript.goToSourceDefinition",
                  arguments = { params.textDocument.uri, params.position },
                  open = true,
                })
              end,
              desc = "Goto Source Definition",
            },
            {
              "tR",
              function()
                LazyVim.lsp.execute({
                  command = "typescript.findAllFileReferences",
                  arguments = { vim.uri_from_bufnr(0) },
                  open = true,
                })
              end,
              desc = "File References",
            },
            {
              "<leader>to",
              LazyVim.lsp.action["source.organizeImports"],
              desc = "Organize Imports",
            },
            {
              "<leader>tM",
              LazyVim.lsp.action["source.addMissingImports.ts"],
              desc = "Add missing imports",
            },
            {
              "<leader>tu",
              LazyVim.lsp.action["source.removeUnused.ts"],
              desc = "Remove unused imports",
            },
            {
              "<leader>tD",
              LazyVim.lsp.action["source.fixAll.ts"],
              desc = "Fix all diagnostics",
            },
            {
              "<leader>tV",
              function()
                LazyVim.lsp.execute({ command = "typescript.selectTypeScriptVersion" })
              end,
              desc = "Select TS workspace version",
            },
          },
        },
        -- go
        gopls = {
          keys = {
            { "<leader>Gi", "<cmd>GoInstallDeps<cr>", desc = "Install Dependencies" },
            { "<leader>Gt", "<cmd>GoTestAdd<cr>", desc = "Add Test" },
            { "<leader>GA", "<cmd>GoTestAll<cr>", desc = "Add All Tests" },
            { "<leader>Ge", "<cmd>GoTestExp<cr>", desc = "Add Exported Tests" },
            { "<leader>Gf", "<cmd>GoGenerate %<cr>", desc = "Generate File" },
            { "<leader>Gaj", "<cmd>GoAddTag<cr>", desc = "Add json tags" },
            { "<leader>Gam", "<cmd>GoAddTag mapstructure<cr>", desc = "Add mapstructure tags" },
            { "<leader>Gae", "<cmd>GoAddTag env<cr>", desc = "Add env tags" },
            { "<leader>Gay", "<cmd>GoAddTag yaml<cr>", desc = "Add YAML tags" },
            { "<leader>GI", "<cmd>GoImplements<cr>", desc = "Find implementions of this method" },
            { "<leader>Gb", "<cmd>GoBuild %<cr>", desc = "Go Build Args" },
            { "<leader>Gc", "<cmd>GoCmt<cr>", desc = "Comment" },
            { "<leader>Gg", "<cmd>GoGenerate<cr>", desc = "Generate" },
            { "<leader>Gr", "<cmd>GoRun %<cr>", desc = "Go Run Args" },
            { "<leader>GT", "<cmd>GoModTidy<cr>", desc = "Tidy" },
            { "<leader>GM", "<cmd>GoMockGen<cr>", desc = "Generate Mocks" },
          },
          settings = {
            gopls = {
              gofumpt = true,
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
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
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
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              semanticTokens = true,
            },
          },
        },
        -- clangd
        clangd = {
          keys = {
            -- { "<leader>C", group = "C++", icon = { icon = "󰙲", color = "blue" } },
            { "<leader>Ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
            { "<leader>Cr", "<cmd>CMakeRun<cr>", desc = "Run Selected Launchable Target" },
            { "<leader>Cl", "<cmd>CMakeLaunchArgs<cr>", desc = "CMakeRun with Additional Argument" },
            { "<leader>Cc", "<cmd>CMakeClean<cr>", desc = "Clean All Targets & Deps" },
            { "<leader>Cq", "<cmd>CMakeClose<cr>", desc = "Close CMake Executor/Runner Window" },
            { "<leader>Cb", "<cmd>CMakeBuild<cr>", desc = "Compile Targets with Pre-build System" },
            { "<leader>Cg", "<cmd>CMakeGenerate<cr>", desc = "Generate Native Build System" },
            { "<leader>Cd", "<cmd>CMakeDebug<cr>", desc = "Debug Selected Launchable Target" },
          },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "Makefile",
              "configure.ac",
              "configure.in",
              "config.h.in",
              "meson.build",
              "meson_options.txt",
              "build.ninja"
            )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
              fname
            ) or require("lspconfig.util").find_git_ancestor(fname)
          end,
          capabilities = {
            offsetEncoding = { "utf-16" },
          },
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        },
        -- lua_ls
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
                disable = { "incomplete-signature-doc", "trailing-space" },
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
                unusedLocalExclude = { "_*" },
              },
            },
          },
        },
        zls = {
          keys = {
            { "<leader>zr", "<cmd>Zig run<cr>", "Run Zig Current File" },
            { "<leader>zb", "<cmd>Zig build<cr>", "Build Current Project" },
            { "<leader>zc", "<cmd>Zig check<cr>", "Check All Current Project Files" },
            { "<leader>zt", "<cmd>Zig task<cr>", "Run a build.zig Task" },
          },
        },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ["javascript"] = { "dprint", { "prettierd", "prettier" } },
        ["javascriptreact"] = { "dprint" },
        ["typescript"] = { "dprint", { "prettierd", "prettier" } },
        ["typescriptreact"] = { "dprint" },
      },
      formatters = {
        dprint = {
          condition = function(_, ctx)
            return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
          end,
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        lua = { "selene", "luacheck" },
        cmake = { "cmakelint" },
      },
      linters = {
        selene = {
          condition = function(ctx)
            local root = LazyVim.root.get({ normalize = true })
            if root ~= vim.uv.cwd() then
              return false
            end
            return vim.fs.find({ "selene.toml" }, { path = root, upward = true })[1]
          end,
        },
        luacheck = {
          condition = function(ctx)
            local root = LazyVim.root.get({ normalize = true })
            if root ~= vim.uv.cwd() then
              return false
            end
            return vim.fs.find({ ".luacheckrc" }, { path = root, upward = true })[1]
          end,
        },
      },
    },
  },
}
