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
        "bibtex",
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
        "rst",
        "nix",
        "org",
        "php",
        "python",
        "requirements",
        "scss",
        "sql",
        "svelte",
        "vue",
        "wgsl",
        "zig",
        "json5",
        "helm",
        "lua",
        "xml",
        "json",
        "haskell",
      })
      if type(opts.highlight.disable) == "table" then
        vim.list_extend(opts.highlight.disable, { "latex" })
      else
        opts.highlight.disable = { "latex" }
      end
    end,
  },
  { "IndianBoy42/tree-sitter-just", event = "BufRead justfile", opts = {} },
}
