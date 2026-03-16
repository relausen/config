return {
  "folke/tokyonight.nvim",
  opts = {
    style = "night",
    dim_inactive = true,
    lualine_bold = true,
    on_highlights = function(highlights, colors)
      highlights.LineNrAbove = {
        fg = "#6e6e6e",
      }
      highlights.LineNrBelow = {
        fg = "#6e6e6e",
      }
    end,
  },
}
