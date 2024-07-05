return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "night",
      dim_inactive = true,
      lualine_bold = true,
      on_highlights = function(highlights, colors)
        highlights.LineNrAbove = { fg = "#6e6e6e" }
        highlights.LineNrBelow = { fg = "#6e6e6e" }
        -- highlights.LineNrAbove = { fg = colors.fg_dark }
        -- highlights.LineNrBelow = { fg = colors.fg_dark }
      end,
    })
    vim.cmd("colorscheme tokyonight")
  end,
}
