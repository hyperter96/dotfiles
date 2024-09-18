local function keymapOptions(desc)
  return {
    noremap = true,
    silent = true,
    nowait = true,
    desc = "GPT prompt " .. desc,
  }
end

return {
  "robitx/gp.nvim",
  config = function()
    require("gp").setup()

    -- Update global context for repo
    vim.keymap.set("v", "<localleader>gX", ":<C-u>'<,'>GpContext<cr>", keymapOptions("Visual Toggle Context"))

    -- Chat commands
    vim.keymap.set({ "n", "i" }, "<localleader>gf", "<cmd>GpChatFinder<cr>", keymapOptions("Chat Finder")) -- Find old chat

    -- Update context (per repository)
    vim.keymap.set({ "n", "i" }, "<localleader>gx", "<cmd>GpContext<cr>", keymapOptions("Toggle Context"))

    -- Normal mode
    vim.keymap.set({ "n", "i" }, "<localleader>gc", "<cmd>GpChatNew vsplit<cr>", keymapOptions("New Chat"))
    vim.keymap.set({ "n", "i" }, "<localleader>gt", "<cmd>GpChatToggle<cr>", keymapOptions("Toggle Chat"))

    -- Chat mode
    vim.keymap.set("v", "<localleader>gC", ":<C-u>'<,'>GpChatNew<cr>", keymapOptions("Visual Chat New"))
    vim.keymap.set("v", "<localleader>gT", ":<C-u>'<,'>GpChatToggle<cr>", keymapOptions("Visual Toggle Chat"))
    vim.keymap.set("v", "<localleader>gp", ":<C-u>'<,'>GpChatPaste<cr>", keymapOptions("Visual Chat Paste"))

    -- Injection mode <C-g>r(ewrite) <C-g>a(ppend)
    vim.keymap.set("v", "<localleader>ga", ":<C-u>'<,'>GpAppend<cr>", keymapOptions("Visual Append (after)"))
    vim.keymap.set("v", "<localleader>gr", ":<C-u>'<,'>GpRewrite<cr>", { desc = "Visual Write" })
  end,
}
