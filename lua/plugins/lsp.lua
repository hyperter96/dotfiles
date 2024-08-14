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
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec" },
    opts = {
      defaults = {},
      spec = {
        {
          mode = { "n", "v" },
          { "<leader>v", group = "Vista", icon = { icon = "󰠶", color = "cyan" } },
        },
      },
    },
  },
  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "NTBBloodbath/zig-tools.nvim" },
      { "ziglang/zig.vim" },
    },
    config = function()
      local lsp_zero = require("lsp-zero")
      local util = require("lspconfig/util")
      -- lsp_attach is where you enable features that only work
      -- if there is a language server active in the file
      local lsp_attach = function(client, bufnr)
        local opts = { buffer = bufnr }

        -- zig
        vim.keymap.set("n", "<leader>zr", "<cmd>Zig run<cr>", { desc = "Run Zig Current File" })
        vim.keymap.set("n", "<leader>zb", "<cmd>Zig build<cr>", { desc = "Build Current Project" })
        vim.keymap.set("n", "<leader>zc", "<cmd>Zig check<cr>", { desc = "Check All Current Project Files" })
        vim.keymap.set("n", "<leader>zt", "<cmd>Zig task<cr>", { desc = "Run a build.zig Task" })

        -- clangd
        vim.keymap.set(
          "n",
          "<leader>Ch",
          "<cmd>ClangdSwitchSourceHeader<cr>",
          { desc = "Switch Source/Header (C/C++)" }
        )
        vim.keymap.set("n", "<leader>Cr", "<cmd>CMakeRun<cr>", { desc = "Run Selected Launchable Target" })
        vim.keymap.set("n", "<leader>Cl", "<cmd>CMakeLauchArgs<cr>", { desc = "CMakeRun with Additional Argument" })
        vim.keymap.set("n", "<leader>Cc", "<cmd>CMakeClean<cr>", { desc = "Clean All Targets & Deps" })
        vim.keymap.set("n", "<leader>Cq", "<cmd>CMakeClose<cr>", { desc = "Close CMake Executor/Runner Window" })
        vim.keymap.set("n", "<leader>Cb", "<cmd>CMakeBuild<cr>", { desc = "Compile Targets with Pre-build System" })
        vim.keymap.set("n", "<leader>Cg", "<cmd>CMakeGenerate<cr>", { desc = "Generate Native Build System" })
        vim.keymap.set("n", "<leader>Cd", "<cmd>CMakeDebug<cr>", { desc = "Debug Selected Launchable Target" })

        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentFormattingRangeProvider = false

        -- gopls
        vim.keymap.set("n", "<leader>Gi", "<cmd>GoInstallDeps<cr>", { desc = "Install Dependencies" })
        vim.keymap.set("n", "<leader>Gt", "<cmd>GoTestAdd<cr>", { desc = "Add Test" })
        vim.keymap.set("n", "<leader>GA", "<cmd>GoTestAll<cr>", { desc = "Add All Tests" })
        vim.keymap.set("n", "<leader>Ge", "<cmd>GoTestExp<cr>", { desc = "Add Exported Tests" })
        vim.keymap.set("n", "<leader>Gf", "<cmd>GoGenerate %<cr>", { desc = "Generate File" })
        vim.keymap.set("n", "<leader>Gaj", "<cmd>GoAddTag<cr>", { desc = "Add json tags" })
        vim.keymap.set("n", "<leader>Gam", "<cmd>GoAddTag mapstructure<cr>", { desc = "Add mapstructure tags" })
        vim.keymap.set("n", "<leader>Gae", "<cmd>GoAddTag env<cr>", { desc = "Add env tags" })
        vim.keymap.set("n", "<leader>Gay", "<cmd>GoAddTag yaml<cr>", { desc = "Add YAML tags" })
        vim.keymap.set("n", "<leader>GI", "<cmd>GoImplements<cr>", { desc = "Find Implementations of this method" })
        vim.keymap.set("n", "<leader>Gb", "<cmd>GoBuild %<cr>", { desc = "Go Build Args" })
        vim.keymap.set("n", "<leader>Gc", "<cmd>GoCmt<cr>", { desc = "Comment" })
        vim.keymap.set("n", "<leader>Gg", "<cmd>GoGenerate<cr>", { desc = "Generate" })
        vim.keymap.set("n", "<leader>Gr", "<cmd>GoRun %<cr>", { desc = "Go Run Args" })
        vim.keymap.set("n", "<leader>GT", "<cmd>GoModTidy<cr>", { desc = "Tidy" })
        vim.keymap.set("n", "<leader>GM", "<cmd>GoMockGen<cr>", { desc = "Generate Mocks" })

        -- vtsls
        vim.keymap.set("n", "<leader>TD", function()
          local params = vim.lsp.util.make_position_params()
          LazyVim.lsp.execute({
            command = "typescript.goToSourceDefinition",
            arguments = { params.textDocument.uri, params.position },
            open = true,
          })
        end, { desc = "Goto Source Definition" })
        vim.keymap.set("n", "<leader>TR", function()
          LazyVim.lsp.execute({
            command = "typescript.findAllFileReferences",
            arguments = { vim.uri_from_bufnr(0) },
            open = true,
          })
        end, { desc = "File References" })
        vim.keymap.set("n", "<leader>To", LazyVim.lsp.action["source.organizeImports"], { desc = "Organize Imports" })
        vim.keymap.set(
          "n",
          "<leader>TM",
          LazyVim.lsp.action["source.addMissingImports.ts"],
          { desc = "Add Missing Imports" }
        )
        vim.keymap.set(
          "n",
          "<leader>Tu",
          LazyVim.lsp.action["source.removeUnused.ts"],
          { desc = "Remove Unused Imports" }
        )
        vim.keymap.set("n", "<leader>Tf", LazyVim.lsp.action["source.fixAll.ts"], { desc = "Fix All Diagnostics" })
        vim.keymap.set("n", "<leader>TV", function()
          LazyVim.lsp.execute({ command = "typescript.selectTypeScriptVersion" })
        end, { desc = "Select TS Workspace Version" })
      end

      lsp_zero.extend_lspconfig({
        sign_text = true,
        lsp_attach = lsp_attach,
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      -- These are just examples. Replace them with the language
      -- servers you have installed in your system

      -- lua_ls
      require("lspconfig").lua_ls.setup({
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
              format = {
								enable = false,
								defaultConfig = {
									indent_style = "space",
									indent_size = "2",
									continuation_indent_size = "2",
								},
							},
            },
          },
      })

      -- zig
      require("lspconfig").zls.setup({
        cmd = { "zls" },
        filetypes = { "zig", "zon" },
        root_dir = util.root_pattern("zls.json", "build.zig"),
      })

      -- clangd
      require("lspconfig").clangd.setup({
              capabilities = {
                offsetEncoding = { "utf-16" },
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
                )(fname) or require("lspconfig.util").root_pattern(
                  "compile_commands.json",
                  "compile_flags.txt"
                )(fname) or require("lspconfig.util").find_git_ancestor(fname)
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
              init_options = {
                usePlaceholders = true,
                completeUnimported = true,
                clangdFileStatus = true,
              },
            })

      -- gopls
      require("lspconfig").gopls.setup({
        on_attach = function(client, bufnr)
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
        end,
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
      })

      -- taplo
      require("lspconfig").taplo.setup({
        keys = {
          {
            "<leader>rK",
            function()
              if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
                require("crates").show_popup()
              else
                vim.lsp.buf.hover()
              end
            end,
            desc = "Show Crate Documentation",
          },
        },
      })

      -- tsserver
      require("lspconfig").tsserver.setup({
        root_dir = function(...)
						return util.root_pattern(".git")(...)
					end,
					single_file_support = false,
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
      })

      -- tailwindcss
      require("lspconfig").tailwindcss.setup({
        root_dir = function(...)
					return util.root_pattern(".git")(...)
				end,
      })

      -- vtsls
      require("lspconfig").vtsls.setup({
        -- explicitly add default filetypes, so that we can extend
        -- them in related extras
        on_attach = function(client, buffer)
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
        end,
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
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
      })
      
      -- texlab
      require("lspconfig").texlab.setup({
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
              args = { "-src", "-silent", "-output-directory=build", "-interaction=nonstopmode", "-synctex=1", "%f" },
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
      })

      -- neocmake
      require("lspconfig").neocmake.setup({})
    end,
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
        clangd = function(_, opts)
          local clangd_ext_opts = LazyVim.opts("clangd_extensions.nvim")
          require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts }))
          return false
        end,
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
  { "VonHeikemen/lsp-zero.nvim", branch = "v4.x" },
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
  {
    "liuchengxu/vista.vim",
    keys = {
      { "<leader>vq", "<cmd>Vista!<cr>", desc = "Close Vista View Window" },
      { "<leader>vt", "<cmd>Vista!!<cr>", desc = "Toggle Vista View Window" },
      { "<leader>vb", "<cmd>Vista focus<cr>", desc = "Jump between Vista Sidebar & Source Code Window" },
      { "<leader>vf", "<cmd>Vista finder<cr>", desc = "Search Tags/Symbols Generated from fzf" },
      { "<leader>vs", "<cmd>Vista show<cr>", desc = "Jump to the Tag Nearby the Current Cursor" },
      { "<leader>vc", "<cmd>Vista toc<cr>", desc = "Show toc of .md File" },
    },
  },
}
