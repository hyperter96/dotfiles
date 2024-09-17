return {
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    event = { { event = "BufReadCmd", pattern = "octo://*" } },
    opts = {
      enable_builtin = true,
      default_to_projects_v2 = true,
      default_merge_method = "squash",
      picker = "telescope",
    },
    keys = {
      { "<leader>oil", "<cmd>Octo issue list<CR>", desc = "List Issues (Octo)" },
      { "<leader>ois", "<cmd>Octo issue search<CR>", desc = "Search Issues (Octo)" },
      { "<leader>opl", "<cmd>Octo pr list<CR>", desc = "List PRs (Octo)" },
      { "<leader>ops", "<cmd>Octo pr search<CR>", desc = "Search PRs (Octo)" },
      { "<leader>or", "<cmd>Octo repo list<CR>", desc = "List Repos (Octo)" },
      { "<leader>os", "<cmd>Octo search<CR>", desc = "Search (Octo)" },

      { "<leader>oaa", "", desc = "+assignee (Octo)", ft = "octo" },
      { "<leader>oca", "", desc = "+comment/code (Octo)", ft = "octo" },
      { "<leader>ola", "", desc = "+label (Octo)", ft = "octo" },
      { "<leader>oia", "", desc = "+issue (Octo)", ft = "octo" },
      { "<leader>oea", "", desc = "+react (Octo)", ft = "octo" },
      { "<leader>opa", "", desc = "+pr (Octo)", ft = "octo" },
      { "<leader>ova", "", desc = "+review (Octo)", ft = "octo" },
      { "@", "@<C-x><C-o>", mode = "i", ft = "octo", silent = true },
      { "#", "#<C-x><C-o>", mode = "i", ft = "octo", silent = true },
    },
  },
  {
    "pwntester/octo.nvim",
    opts = function(_, opts)
      vim.treesitter.language.register("markdown", "octo")
      if LazyVim.has("telescope.nvim") then
        opts.picker = "telescope"
      elseif LazyVim.has("fzf-lua") then
        opts.picker = "fzf-lua"
      else
        LazyVim.error("`octo.nvim` requires `telescope.nvim` or `fzf-lua`")
      end

      -- Keep some empty windows in sessions
      vim.api.nvim_create_autocmd("ExitPre", {
        group = vim.api.nvim_create_augroup("octo_exit_pre", { clear = true }),
        callback = function(ev)
          local keep = { "octo" }
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.tbl_contains(keep, vim.bo[buf].filetype) then
              vim.bo[buf].buftype = "" -- set buftype to empty to keep the window
            end
          end
        end,
      })
    end,
  },
}
