return {
  {
    "vuki656/package-info.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    config = function()
      require("package-info").setup()
      -- Show dependency versions
      vim.keymap.set(
        { "n" },
        "<LEADER>ns",
        require("package-info").show,
        { desc = "Show Dependency Versions", silent = true, noremap = true }
      )

      -- Hide dependency versions
      vim.keymap.set(
        { "n" },
        "<LEADER>nc",
        require("package-info").hide,
        { desc = "Hide Dependency Versions", silent = true, noremap = true }
      )

      -- Toggle dependency versions
      vim.keymap.set(
        { "n" },
        "<LEADER>nt",
        require("package-info").toggle,
        { desc = "Toggle Dependency Versions", silent = true, noremap = true }
      )

      -- Update dependency on the line
      vim.keymap.set(
        { "n" },
        "<LEADER>nu",
        require("package-info").update,
        { desc = "Update Dependency on the Line", silent = true, noremap = true }
      )

      -- Delete dependency on the line
      vim.keymap.set(
        { "n" },
        "<LEADER>nd",
        require("package-info").delete,
        { desc = "Delete Dependency on the Line", silent = true, noremap = true }
      )

      -- Install a new dependency
      vim.keymap.set(
        { "n" },
        "<LEADER>ni",
        require("package-info").install,
        { desc = "Install a New Dependency", silent = true, noremap = true }
      )

      -- Install a different dependency version
      vim.keymap.set(
        { "n" },
        "<LEADER>np",
        require("package-info").change_version,
        { desc = "Install a Different Dependency Version", silent = true, noremap = true }
      )
    end,
  },
}
