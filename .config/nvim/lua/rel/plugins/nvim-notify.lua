return {
    "rcarriga/nvim-notify",
    lazy = false,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        level = vim.log.levels.INFO,
        timeout = 1000,
    },
}
