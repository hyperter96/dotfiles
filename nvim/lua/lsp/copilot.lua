local chat = require("CopilotChat")

-- toggle
vim.keymap.set("n", "<leader>kt", chat.toggle, { desc = "Toggle Copilot Chat" })
-- stop
vim.keymap.set("n", "<leader>kq", chat.stop, { desc = "Stop Copilot Chat" })

-- explain the code
vim.keymap.set("v", "<leader>ke", "<cmd>CopilotChatExplain<cr>", { desc = "CopilotChat - Explain the code" })
-- review the code
vim.keymap.set("v", "<leader>kr", "<cmd>CopilotChatReview<cr>", { desc = "CopilotChat - Review the code" })
-- fix the code
vim.keymap.set("v", "<leader>kx", "<cmd>CopilotChatFix<cr>", { desc = "CopilotChat - Fix the code" })
-- optimize the code
vim.keymap.set("v", "<leader>ko", "<cmd>CopilotChatOptimize<cr>", { desc = "CopilotChat - Optimize the code" })
-- add the docs
vim.keymap.set("v", "<leader>kD", "<cmd>CopilotChatDocs<cr>", { desc = "CopilotChat - Add the docs" })
-- quick ask
vim.keymap.set("v", "<leader>kQ", function()
  local input = vim.fn.input("Quick Chat: ")
  if input ~= "" then
    require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
  end
end, {
  desc = "CopilotChat - Quick chat",
})
