return {
  "rcarriga/nvim-notify",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    level = vim.log.levels.INFO,
    timeout = 1000,
  },
}
