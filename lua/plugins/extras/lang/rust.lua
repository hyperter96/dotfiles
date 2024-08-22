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
          { "<leader>r", group = "Rust", icon = { icon = "󱘗", color = "red" } },
        },
      },
    },
  },
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        cmp = { enabled = true },
      },
    },
  },
  {
    "mrcjkb/rustaceanvim",
    dependencies = "ray-x/navigator.lua",
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
          require('navigator.lspclient.mapping').setup({client=client, bufnr=bufnr}) -- setup navigator keymaps here,

          require("navigator.dochighlight").documentHighlight(bufnr)
          require('navigator.codeAction').code_action_prompt(bufnr)

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
          vim.keymap.set("n", "<leader>re", function ()
            vim.cmd.RustLsp('explainError')
          end, { desc = "Explain Errors", buffer = bufnr})
          -- hover
          vim.keymap.set("n", "<leader>rh", function()
            vim.cmd.RustLsp{"hover","actions"}
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
          vim.keymap.set("n", "<leader>rd", function ()
            vim.cmd.RustLsp('renderDiagnostic')
          end, { desc = "Render Diagnostics", buffer = bufnr})
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

      lsp_zero.extend_lspconfig({
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

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
