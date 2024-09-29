local ext = require("utils.fn").ext
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
    vim.keymap.set("n", "<leader>CU", crates.upgrade_crate, ext(opts, "desc", "Upgrade Crate in the Current Line"))
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
