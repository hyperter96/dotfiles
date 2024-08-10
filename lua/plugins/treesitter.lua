return {
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false, -- last release is way too old
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "cmake",
        "cpp",
        "rust",
        "ron",
        -- "comment", -- comments are slowing down TS bigtime, so disable for now
        "css",
        "devicetree",
        "git_config",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "glsl",
        "go",
        "gomod",
        "gowork",
        "gosum",
        "graphql",
        "http",
        "markdown",
        "markdown_inline",
        "kconfig",
        "meson",
        "ninja",
        "nix",
        "org",
        "php",
        "scss",
        "sql",
        "svelte",
        "vue",
        "wgsl",
        "zig",
        "json5",
        "helm",
      })
    end,
  },
  { "IndianBoy42/tree-sitter-just", event = "BufRead justfile", opts = {} },
  {
    "https://github.com/Samonitari/tree-sitter-caddy",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
        parser_config.caddy = {
          install_info = {
            url = "https://github.com/Samonitari/tree-sitter-caddy",
            files = { "src/parser.c", "src/scanner.c" },
            branch = "master",
          },
          filetype = "caddy",
        }

        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, { "caddy" })
        vim.filetype.add({
          pattern = {
            ["Caddyfile"] = "caddy",
          },
        })
      end,
    },
    event = "BufRead Caddyfile",
  },
}
