return {
  "abecodes/tabout.nvim",
  enabled = false,
  dependencies = {
    "hrsh7th/nvim-cmp",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("tabout").setup({})
  end,
}
