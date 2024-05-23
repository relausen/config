return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "night",
      dim_inactive = true,
      lualine_bold = true,
      hide_inactive_statusline = true,
      on_highlights = function(highlights, colors)
        highlights.LineNrAbove = { fg = colors.fg_dark }
        highlights.LineNrBelow = { fg = colors.fg_dark }
      end,
    })
    vim.cmd("colorscheme tokyonight")
  end,
}
