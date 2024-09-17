local ext = require("utils.fn").ext
local LazyVim = require("lazy.util")

return {
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    config = function()
      require("crates").setup({
        on_attach = function(bufnr)
          local crates = require("crates")
          local opts = { silent = true }

          vim.keymap.set("n", "<leader>Ct", crates.toggle, ext(opts, "desc", "Toggle UI elements"))
          vim.keymap.set("n", "<leader>Cr", crates.reload, ext(opts, "desc", "Reload Data (Clear Cache)"))

          vim.keymap.set("n", "<leader>Cv", crates.show_versions_popup, ext(opts, "desc", "Show Versions"))
          vim.keymap.set("n", "<leader>Cf", crates.show_features_popup, ext(opts, "desc", "Show Features"))
          vim.keymap.set("n", "<leader>Cd", crates.show_dependencies_popup, ext(opts, "desc", "Show Dependencies"))

          vim.keymap.set("n", "<leader>Cu", crates.update_crate, ext(opts, "desc", "Update Crate in the Current Line"))
          vim.keymap.set(
            "v",
            "<leader>Cu",
            crates.update_crates,
            ext(opts, "desc", "Update Crates Selected in the Visual Mode")
          )
          vim.keymap.set("n", "<leader>Ca", crates.update_all_crates, ext(opts, "desc", "Update All Crates"))
          vim.keymap.set(
            "n",
            "<leader>CU",
            crates.upgrade_crate,
            ext(opts, "desc", "Upgrade Crate in the Current Line")
          )
          vim.keymap.set(
            "v",
            "<leader>CU",
            crates.upgrade_crates,
            ext(opts, "desc", "Upgrade Crates Selected in the Visual Mode")
          )
          vim.keymap.set("n", "<leader>CA", crates.upgrade_all_crates, ext(opts, "desc", "Upgrade All Crates"))

          vim.keymap.set(
            "n",
            "<leader>Cx",
            crates.expand_plain_crate_to_inline_table,
            ext(opts, "desc", "Expand a plain crate declaration into an inline table")
          )
          vim.keymap.set(
            "n",
            "<leader>CX",
            crates.extract_crate_into_table,
            ext(opts, "desc", "Extract an crate declaration from a dependency section")
          )

          vim.keymap.set("n", "<leader>CH", crates.open_homepage, ext(opts, "desc", "Open the Homepage of the Crate"))
          vim.keymap.set("n", "<leader>CR", crates.open_repository, ext(opts, "desc", "Open the Repo of the Crate"))
          vim.keymap.set("n", "<leader>CD", crates.open_documentation, ext(opts, "desc", "Open the Docs of the Crate"))
          vim.keymap.set("n", "<leader>CC", crates.open_crates_io, ext(opts, "desc", "Open the 'crate.io' Page"))
          vim.keymap.set("n", "<leader>CL", crates.open_lib_rs, ext(opts, "desc", "Open 'lib.rs' Page"))
        end,
        completion = {
          crates = {
            enabled = true, -- disabled by default
            max_results = 8, -- The maximum number of search results to display
            min_chars = 3, -- The minimum number of charaters to type before completions begin appearing
          },
          coq = {
            enabled = true,
            name = "crates.nvim",
          },
          cmp = {
            enabled = true,
          },
        },
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
        lsp = {
          enabled = true,
          on_attach = function(client, bufnr)
            -- the same on_attach function as for your other lsp's
          end,
          actions = true,
          completion = true,
          hover = true,
        },
      })
    end,
    opts = {
      completion = {
        cmp = { enabled = true },
      },
    },
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    ft = { "rust" },
    opts = {
      tools = {
        hover_actions = {
          replace_builtin_hover = false,
        },
        float_win_config = {
          auto_focus = true,
        },
      },
      server = {
        on_attach = function(client, bufnr)
          -- cargo run
          vim.keymap.set("n", "<leader>rr", function()
            vim.cmd.RustLsp("runnables")
          end, { desc = "Rust Runnables", buffer = bufnr })
          -- cargo test
          vim.keymap.set("n", "<leader>rt", function()
            vim.cmd.RustLsp("testables")
          end, { desc = "Rust Testables", buffer = bufnr })
          -- cargo expand
          vim.keymap.set("n", "<leader>rM", function()
            vim.cmd.RustLsp("expandMacros")
          end, { desc = "Expand Macros", buffer = bufnr })
          -- explain errors
          vim.keymap.set("n", "<leader>re", function()
            vim.cmd.RustLsp("explainError")
          end, { desc = "Explain Errors", buffer = bufnr })
          -- hover
          vim.keymap.set("n", "<leader>rh", function()
            vim.cmd.RustLsp({ "hover", "actions" })
          end, { desc = "Hover Actions", buffer = bufnr })
          -- rebuild Macros
          vim.keymap.set("n", "<leader>rR", function()
            vim.cmd.RustLsp("rebuildProcMacros")
          end, { desc = "Rebuild Macros", buffer = bufnr })
          -- code Action
          vim.keymap.set("n", "<leader>rA", function()
            vim.cmd.RustLsp("codeAction")
          end, { desc = "Code Action", buffer = bufnr })
          -- debug
          vim.keymap.set("n", "<leader>rD", function()
            vim.cmd.RustLsp("debuggables")
          end, { desc = "Rust Debuggables", buffer = bufnr })
          -- render diagnostics
          vim.keymap.set("n", "<leader>rd", function()
            vim.cmd.RustLsp("renderDiagnostic")
          end, { desc = "Render Diagnostics", buffer = bufnr })
          -- open cargo
          vim.keymap.set("n", "<leader>rc", function()
            vim.cmd.RustLsp("openCargo")
          end, { desc = "Open Cargo.toml", buffer = bufnr })
        end,
        default_settings = {
          -- rust-analyzer language server configuration
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = {
                enable = true,
              },
            },
            -- Add clippy lints for Rust.
            checkOnSave = true,
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
          },
        },
      },
    },
    config = function(_, opts)
      local lsp_zero = require("lsp-zero")

      -- lsp_zero.extend_lspconfig({
      --   capabilities = require("cmp_nvim_lsp").default_capabilities(),
      -- })

      vim.g.rustaceanvim = {
        server = {
          capabilities = lsp_zero.get_capabilities(),
        },
      }
      vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
      if vim.fn.executable("rust-analyzer") == 0 then
        LazyVim.error(
          "**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/",
          { title = "rustaceanvim" }
        )
      end
      require("mason").setup({})
      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({})
          end,
          rust_analyzer = lsp_zero.noop,
        },
      })
    end,
  },
}
