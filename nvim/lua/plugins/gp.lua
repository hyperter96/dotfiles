local kmOpts = require("utils/fn").keymapOptions

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
    vim.keymap.set("v", "<leader>pX", ":<C-u>'<,'>GpContext<cr>", kmOpts("Visual Toggle Context"))

    -- Chat commands
    vim.keymap.set({ "n", "i" }, "<leader>pf", "<cmd>GpChatFinder<cr>", kmOpts("Chat Finder")) -- Find old chat

    -- Update context (per repository)
    vim.keymap.set({ "n", "i" }, "<leader>px", "<cmd>GpContext<cr>", kmOpts("Toggle Context"))

    -- Normal mode
    vim.keymap.set({ "n", "i" }, "<leader>pc", "<cmd>GpChatNew vsplit<cr>", kmOpts("New Chat"))
    vim.keymap.set({ "n", "i" }, "<leader>pt", "<cmd>GpChatToggle<cr>", kmOpts("Toggle Chat"))

    -- Chat mode
    vim.keymap.set("v", "<leader>pC", ":<C-u>'<,'>GpChatNew<cr>", kmOpts("Visual Chat New"))
    vim.keymap.set("v", "<leader>pT", ":<C-u>'<,'>GpChatToggle<cr>", kmOpts("Visual Toggle Chat"))
    vim.keymap.set("v", "<leader>pp", ":<C-u>'<,'>GpChatPaste<cr>", kmOpts("Visual Chat Paste"))

    -- Injection mode <C-g>r(ewrite) <C-g>a(ppend)
    vim.keymap.set("v", "<leader>pa", ":<C-u>'<,'>GpAppend<cr>", kmOpts("Visual Append (after)"))
    vim.keymap.set("v", "<leader>pr", ":<C-u>'<,'>GpRewrite<cr>", { desc = "Visual Write" })

    -- optional Whisper commands with prefix <C-g>w

    vim.keymap.set({ "n", "i" }, "<leader>pw", "<cmd>GpWhisper<cr>", kmOpts("Whisper"))
    vim.keymap.set("v", "<leader>pw", ":<C-u>'<,'>GpWhisper<cr>", kmOpts("Visual Whisper"))

    vim.keymap.set({ "n", "i" }, "<leader>pR", "<cmd>GpWhisperRewrite<cr>", kmOpts("Whisper Inline Rewrite"))
    vim.keymap.set({ "n", "i" }, "<leader>pa", "<cmd>GpWhisperAppend<cr>", kmOpts("Whisper Append (after)"))
    vim.keymap.set({ "n", "i" }, "<leader>pP", "<cmd>GpWhisperPrepend<cr>", kmOpts("Whisper Prepend (before) "))

    vim.keymap.set("v", "<leader>pR", ":<C-u>'<,'>GpWhisperRewrite<cr>", kmOpts("Visual Whisper Rewrite"))
    vim.keymap.set("v", "<leader>pa", ":<C-u>'<,'>GpWhisperAppend<cr>", kmOpts("Visual Whisper Append (after)"))
    vim.keymap.set("v", "<leader>pP", ":<C-u>'<,'>GpWhisperPrepend<cr>", kmOpts("Visual Whisper Prepend (before)"))

    vim.keymap.set({ "n", "i" }, "<leader>pu", "<cmd>GpWhisperPopup<cr>", kmOpts("Whisper Popup"))
    vim.keymap.set({ "n", "i" }, "<leader>pe", "<cmd>GpWhisperEnew<cr>", kmOpts("Whisper Enew"))
    vim.keymap.set({ "n", "i" }, "<leader>pn", "<cmd>GpWhisperNew<cr>", kmOpts("Whisper New"))
    vim.keymap.set({ "n", "i" }, "<leader>pv", "<cmd>GpWhisperVnew<cr>", kmOpts("Whisper Vnew"))
    vim.keymap.set({ "n", "i" }, "<leader>pb", "<cmd>GpWhisperTabnew<cr>", kmOpts("Whisper Tabnew"))

    vim.keymap.set("v", "<leader>pu", ":<C-u>'<,'>GpWhisperPopup<cr>", kmOpts("Visual Whisper Popup"))
    vim.keymap.set("v", "<leader>pe", ":<C-u>'<,'>GpWhisperEnew<cr>", kmOpts("Visual Whisper Enew"))
    vim.keymap.set("v", "<leader>pn", ":<C-u>'<,'>GpWhisperNew<cr>", kmOpts("Visual Whisper New"))
    vim.keymap.set("v", "<leader>pv", ":<C-u>'<,'>GpWhisperVnew<cr>", kmOpts("Visual Whisper Vnew"))
    vim.keymap.set("v", "<leader>pb", ":<C-u>'<,'>GpWhisperTabnew<cr>", kmOpts("Visual Whisper Tabnew"))
  end,
}
