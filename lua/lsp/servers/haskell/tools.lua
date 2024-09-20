local wrap = require("utils.fn").wrap
return {
  setup = function(on_attach, capabilities)
    require("lsp.servers.haskell.hoogle")
    require("lsp.servers.haskell.snippets")

    local ok, telescope = pcall(require, "telescope")
    if ok then
      telescope.load_extension("ht")
    end

    ---
    -- Setup haskell LSP
    ---

    vim.g.haskell_tools = {
      hls = {
        capabilities = capabilities,
        debug = false,
        logfile = "",
      },
    }

    -- Autocmd that will actually be in charging of starting hls
    local hls_augroup = vim.api.nvim_create_augroup("haskell-lsp", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = hls_augroup,
      pattern = { "haskell" },
      callback = function()
        ---
        -- Suggested keymaps from the quick setup section:
        -- https://github.com/mrcjkb/haskell-tools.nvim#quick-setup
        ---

        local ht = require("haskell-tools")
        -- haskell-language-server relies heavily on codeLenses,
        -- so auto-refresh (see advanced configuration) is enabled by default
        vim.keymap.set("n", "<space>ha", vim.lsp.codelens.run, { desc = "Auto-refresh" })
        -- Hoogle search for the type signature of the definition under the cursor
        vim.keymap.set("n", "<space>hs", ht.hoogle.hoogle_signature, { desc = "Hoogle Search for the Type Signature" })
        -- Evaluate all code snippets
        vim.keymap.set("n", "<space>hc", ht.lsp.buf_eval_all, { desc = "Evaluate all Code Snippets" })
        -- Toggle a GHCi repl for the current package
        vim.keymap.set("n", "<leader>hr", ht.repl.toggle, { desc = "Toggle a GHCi Repl for Current Package" })
        -- Load a File in the current Repl
        vim.keymap.set(
          "n",
          "<leader>hl",
          wrap(ht.repl.load_file, vim.api.nvim_buf_get_name(0)),
          { desc = "Load a File in the Current Repl" }
        )
        -- Reload a File in the current Repl
        vim.keymap.set("n", "<leader>hL", ht.repl.reload, { desc = "Reload a File in the Current Repl" })
        -- Toggle a GHCi repl for the current buffer
        vim.keymap.set("n", "<leader>hf", function()
          ht.repl.toggle(vim.api.nvim_buf_get_name(0))
        end, { desc = "Toggle a GHCi Repl for Current Buffer" })
        -- Quit the GHCi Repl
        vim.keymap.set("n", "<leader>hq", ht.repl.quit, { desc = "Quit the GHCi Repl" })
        -- Generate Project tags
        local opt = { refresh = true }
        vim.keymap.set(
          "n",
          "<leader>hg",
          wrap(ht.tags.generate_project_tags, vim.api.nvim_buf_get_name(0), opt),
          { desc = "Generate Project Tags" }
        )
        -- Generate Package tags
        vim.keymap.set(
          "n",
          "<leader>hp",
          wrap(ht.tags.generate_package_tags, vim.api.nvim_buf_get_name(0)),
          { desc = "Generate Package Tags" }
        )
        -- Query the Repl for info on the word under the cursor
        vim.keymap.set("n", "<leader>hQ", ht.repl.cword_info, { desc = "Query the Repl for Info on the Word" })
        -- Query the Repl for the type of word under the cursor
        vim.keymap.set("n", "<leader>ht", ht.repl.cword_type, { desc = "Query the Repl for the Type of Word" })
      end,
    })
  end,
}
