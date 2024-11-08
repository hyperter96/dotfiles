return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufRead", "BufNewFile" }, -- 当读取文件或创建新文件时加载
    opts = {
      ensure_installed = {
        "bibtex",
        "cmake",
        "cpp",
        "rust",
        "ron",
        -- "comment", -- comments are slowing down TS bigtime, so disable for now
        "css",
        "devicetree",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "glsl",
        "go",
        "gotmpl",
        "yaml",
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
        "latex",
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
        "wit",
        "proto",
        "javascript",
        "typescript",
        "haskell",
        "java",
      },
      highlight = {
        enable = true, -- 启用高亮
        additional_vim_regex_highlighting = false,
      },
      textobjects = {
        move = {
          enable = true,
          set_jumps = false, -- you can change this if you want.
          goto_next_start = {
            --- ... other keymaps
            ["]b"] = { query = "@code_cell.inner", desc = "next code block" },
          },
          goto_previous_start = {
            --- ... other keymaps
            ["[b"] = { query = "@code_cell.inner", desc = "previous code block" },
          },
        },
        select = {
          enable = true,
          lookahead = true, -- you can change this if you want
          keymaps = {
            --- ... other keymaps
            ["ib"] = { query = "@code_cell.inner", desc = "in block" },
            ["ab"] = { query = "@code_cell.outer", desc = "around block" },
          },
        },
        swap = { -- Swap only works with code blocks that are under the same
          -- markdown header
          enable = true,
          swap_next = {
            --- ... other keymap
            ["<leader>sbl"] = "@code_cell.outer",
          },
          swap_previous = {
            --- ... other keymap
            ["<leader>sbh"] = "@code_cell.outer",
          },
        },
      },
    },
  },
  {
    "davidmh/mdx.nvim",
    config = true,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
}
