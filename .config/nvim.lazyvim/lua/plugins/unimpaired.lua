return {
  "tummetott/unimpaired.nvim",
  event = "VeryLazy",
  opts = {
    default_keymaps = false,
    keymaps = {
      blank_above = {
        mapping = "[<Space>",
        description = "Add [count] blank lines above",
        dot_repeat = true,
      },
      blank_below = {
        mapping = "]<Space>",
        description = "Add [count] blank lines below",
        dot_repeat = true,
      },
    },
  },
}
