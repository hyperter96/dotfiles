return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    -- REQUIRED
    harpoon:setup()
    -- REQUIRED

    -- basic telescope configuration
    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers")
        .new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        })
        :find()
    end

    vim.keymap.set("n", "<leader>bL", function()
      toggle_telescope(harpoon:list())
    end, { desc = "Open harpoon window" })

    vim.keymap.set("n", "<leader>ba", function()
      harpoon:list():add()
    end, { desc = "Add harpoon buffer" })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<leader>bv", function()
      harpoon:list():prev()
    end, { desc = "To previous harpoon buffer" })
    vim.keymap.set("n", "<leader>bn", function()
      harpoon:list():next()
    end, { desc = "To next harpoon buffer" })
  end,
}
