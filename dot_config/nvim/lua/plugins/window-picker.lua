return {
  "s1n7ax/nvim-window-picker",
  name = "window-picker",
  event = "VeryLazy",
  version = "2.*",
  opts = {
    show_prompt = false,
    highlights = {
      enabled = true,
      statusline = {
        focused = {
          fg = "#ededed",
          bg = "#e35e4f",
          bold = true,
        },
        unfocused = {
          fg = "#ededed",
          bg = "#44cc41",
          bold = true,
        },
      },
      winbar = {
        focused = {
          fg = "#ededed",
          bg = "#e35e4f",
          bold = true,
        },
        unfocused = {
          fg = "#ededed",
          bg = "#44cc41",
          bold = true,
        },
      },
    },
  },
  -- config = function()
  --   require("window-picker").setup()
  -- end,
}
