return {
  'numToStr/Comment.nvim',
  event = { "BufReadPre", "BufNewFile" },
  config = true,
  opts = {
    ignore = "^$",
  },
}
