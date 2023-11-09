return {
  "folke/which-key.nvim",
  lazy = false,
  init = function()
    vim.opt.timeout = true
    vim.opt.timeoutlen = 500
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
}
