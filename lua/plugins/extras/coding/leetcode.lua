local leet_arg = "leetcode.nvim"

return {
  {
    "kawre/leetcode.nvim",
    lazy = leet_arg ~= vim.fn.argv()[1],
    opts = {
      arg = leet_arg,
      cn = { -- leetcode.cn
        enabled = true,
        translator = true,
        translate_problems = true,
      },
    },
  },
}
