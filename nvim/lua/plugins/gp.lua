local function keymapOptions(desc)
  return {
    noremap = true,
    silent = true,
    nowait = true,
    desc = "GPT prompt: " .. desc,
  }
end

return {
  "robitx/gp.nvim",
  config = function()
    local conf = {
      providers = {
        openai = {
          disable = true,
        },
        ollama = {
          endpoint = "http://localhost:11434/v1/chat/completions",
        },
        copilot = {
          disable = false,
          endpoint = "https://api.githubcopilot.com/chat/completions",
          secret = {
            "bash",
            "-c",
            "cat ~/.config/github-copilot/apps.json | sed -e 's/.*oauth_token...//;s/\".*//'",
          },
        },
      },
    }
    require("gp").setup(conf)

    -- Update global context for repo
    vim.keymap.set("v", "<leader>pX", ":<C-u>'<,'>GpContext<cr>", keymapOptions("Visual Toggle Context"))

    -- Chat commands
    vim.keymap.set({ "n", "i" }, "<leader>pf", "<cmd>GpChatFinder<cr>", keymapOptions("Chat Finder")) -- Find old chat

    -- Update context (per repository)
    vim.keymap.set({ "n", "i" }, "<leader>px", "<cmd>GpContext<cr>", keymapOptions("Toggle Context"))

    -- Normal mode
    vim.keymap.set({ "n", "i" }, "<leader>pc", "<cmd>GpChatNew vsplit<cr>", keymapOptions("New Chat"))
    vim.keymap.set({ "n", "i" }, "<leader>pt", "<cmd>GpChatToggle<cr>", keymapOptions("Toggle Chat"))

    -- Chat mode
    vim.keymap.set("v", "<leader>pC", ":<C-u>'<,'>GpChatNew<cr>", keymapOptions("Visual Chat New"))
    vim.keymap.set("v", "<leader>pT", ":<C-u>'<,'>GpChatToggle<cr>", keymapOptions("Visual Toggle Chat"))
    vim.keymap.set("v", "<leader>pp", ":<C-u>'<,'>GpChatPaste<cr>", keymapOptions("Visual Chat Paste"))

    -- Injection mode <C-g>r(ewrite) <C-g>a(ppend)
    vim.keymap.set("v", "<leader>pa", ":<C-u>'<,'>GpAppend<cr>", keymapOptions("Visual Append (after)"))
    vim.keymap.set("v", "<leader>pr", ":<C-u>'<,'>GpRewrite<cr>", { desc = "Visual Write" })
  end,
}
