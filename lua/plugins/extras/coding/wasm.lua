return {
  {
    "Borwe/wasm_nvim",
    optional = false,
    config = function()
      -- load wasm_nvim
      require("wasm_nvim").setup({
        debug = true, -- uncomment to see debug info printed out, good for debugging issues.
      })
    end,
  },
}
