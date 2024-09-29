return {
  -- {
  --   dir = "~/go/src/nui-spectre", -- Your path
  --   name = "nui-spectre.nvim",
  --   config = function()
  --     require("nui-spectre")
  --   end,
  -- },
  {
    "nvim-pack/nvim-spectre",
    config = function()
      require("spectre").setup({
        default = {
          replace = {
            cmd = "oxi",
          },
        },
      })
    end,
  },
}
