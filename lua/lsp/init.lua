local lsp_zero = require("lsp-zero")
local lsp_format_ok, lsp_format = pcall(require, "lsp-format")
local u = require("functions.utils")
-- This is the callback function that runs after LSP attaches which configures the LSP,
-- which sets the LSP settings like formatting and keymaps, etc.
local on_attach = function(client, bufnr)
  local function buf_set_option(name, value)
    vim.api.nvim_set_option_value(name, value, { buf = bufnr })
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
  -- Debounce by 300ms by default
  -- client.config.flags.debounce_text_changes = 300

  -- This will set up formatting for the attached LSPs
  client.server_capabilities.documentFormattingProvider = true
  client.server_capabilities.documentSymbolProvider = true

  -- Turn off semantic tokens (too slow)
  client.server_capabilities.semanticTokensProvider = nil

  -- Formatting for Vue handled by Eslint
  if u.has_value({
    "eslint",
    "gopls",
    "lua_ls",
    "clangd",
    "pylsp",
  }, client.name) then
    if client.supports_method("textDocument/formatting") then
      lsp_format.on_attach(client)
    end
  end

  -- This is ripped off from https://github.com/kabouzeid/dotfiles, it's for tailwind preview support
  if client.name == "tailwindcss" then
    require("lsp/colorizer").buf_attach(bufnr, { single_column = false, debounce = 500 })
  end
end

-- extend ufo with lsp_zero
local lsp_capabilities = vim.tbl_deep_extend("force", require("cmp_nvim_lsp").default_capabilities(), {
  textDocument = {
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    },
  },
})

lsp_zero.extend_lspconfig({
  sign_text = true,
  lsp_attach = on_attach,
  capabilities = lsp_capabilities,
})

local map_opts = { noremap = true, silent = true, nowait = true }
local cmp_nvim_lsp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local mason_status_ok, mason = pcall(require, "mason")
local mason_tool_installer_ok, mason_tool_installer = pcall(require, "mason-tool-installer")

if not (mason_status_ok and mason_tool_installer_ok and cmp_nvim_lsp_status_ok and lsp_format_ok) then
  vim.api.nvim_err_writeln("Mason, Mason Tool Installer, Completion, or LSP Format not installed!")
  return
end

lsp_format.setup({
  order = {
    "ts_ls",
    "eslint",
  },
})

local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")

mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

if not configs.protolint then
  configs.protolint = {
    default_config = {
      cmd = { "protolint", "lint", "." },
      filetypes = { "proto" },
      root_dir = lspconfig.util.root_pattern(".git", ".protolint.json", ".protolint.yaml", ".protolintrc.yml"),
    },
  }
end

if not configs.protobuf_language_server then
  configs.protobuf_language_server = {
    default_config = {
      cmd = { "/root/go/bin/protobuf-language-server" },
      filetypes = { "proto", "cpp" },
      root_fir = lspconfig.util.root_pattern(".git"),
      single_file_support = true,
      settings = {
        ["additional-proto-dirs"] = {
          -- path to additional protobuf directories
          -- "vendor",
          "third_party",
        },
      },
    },
  }
end

-- These tools are automatically installed by Mason.
-- We then iterate over the LSPs (only) and load their relevant
-- configuration files, which are stored in lua/lsp/servers,
-- passing along the global on_attach and capabilities functions

-- We could have configurations for the other tools but it's not
-- been necessary for me thus far
-- "black",
-- "codelldb",
-- "clangd",
-- "clang-format",
-- "cmakelang",
-- "cmakelint",
-- "eslint_d",
-- "goimports",
-- "gofumpt",
-- "gopls",
-- "pyright",
-- "debugpy",
-- "gomodifytags",
-- "impl",
-- "isort",
-- "delve",
-- "markdownlint-cli2",
-- "markdown-toc",
-- "zls",
-- "texlab",
-- "js-debug-adapter",
-- "eslint-lsp",
-- "json-lsp",
-- "prettier",
-- "protolint",
-- "yaml-language-server",
-- "typescript-language-server",
-- "tailwindcss-language-server",
-- "ansible-lint",
-- "ltex-ls",
-- "hadolint",
-- "vue-language-server",
-- "taplo",
-- "jdtls",
-- "java-debug-adapter",
-- "java-test",
-- "google-java-format",
-- "haskell-language-server",
-- "haskell-debug-adapter",
local servers = {
  "autotools-language-server",
  "lua-language-server",
  "eslint-lsp",
  "bash-language-server",
  "gopls",
  "texlab",
  "typescript-language-server",
  "tailwindcss-language-server",
  "vue-language-server",
  "golangci-lint-langserver",
  "ltex-ls",
  "python-lsp-server",
  "css-lsp",
  "clangd",
  "protolint",
  "zls",
  "taplo",
  "json-lsp",
  "jdtls",
  "yaml-language-server",
}

local formatters = {
  "gofumpt",
  "prettier",
  "google-java-format",
  "clang-format",
}

local linters = {
  "pylint",
  "black",
  "eslint_d",
  "isort",
  "hadolint",
  "markdownlint-cli2",
  "cmakelint",
}

local debuggers = {
  "debugpy",
  "codelldb",
  "haskell-debug-adapter",
  "js-debug-adapter",
  "delve",
  "java-debug-adapter",
  "java-test",
  "node-debug2-adapter",
}

local all = u.merge(servers, linters, debuggers, formatters)

-- Setup Mason + LSPs + CMP
require("lsp.cmp")
mason_tool_installer.setup({
  ensure_installed = all,
  run_on_start = true,
  automatic_installation = true,
})

-- Setup each server
-- local capabilities = cmp_nvim_lsp.default_capabilities(normal_capabilities)
-- local normal_capabilities = cmp_nvim_lsp.default_capabilities()
-- normal_capabilities.textDocument.foldingRange = {
--   dynamicRegistration = false,
--   lineFoldingOnly = true,
-- }
for _, s in pairs(servers) do
  local server_config_ok, mod = pcall(require, "lsp.servers." .. s)
  if not server_config_ok then
    require("notify")("The LSP '" .. s .. "' does not have a config.", "warn")
  else
    mod.setup(on_attach, lsp_zero.get_capabilities())
  end
end

require("lspconfig").protobuf_language_server.setup({
  on_attach = on_attach,
  capabilities = lsp_zero.get_capabilities(),
})

require("lsp.servers.rustaceanvim").setup({
  on_attach = on_attach,
  capabilities = lsp_zero.get_capabilities(),
})

require("lsp.servers.haskell.tools").setup({
  on_attach = on_attach,
  capabilities = lsp_zero.get_capabilities(),
})

-- Global diagnostic settings
vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  update_in_insert = false,
  float = {
    header = "",
    source = true,
    border = "solid",
    focusable = true,
  },
})

require("lsp.servers.crates")
