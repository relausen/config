return {
  "abecodes/tabout.nvim",
  dependencies = {
    "hrsh7th/nvim-cmp",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function ()
    require('tabout').setup {
    }
  end
}
