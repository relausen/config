return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        files = {
          hidden = true,
        },
        projects = {
          dev = { "~/development" },
        },
      },
    },
    image = {},
    scroll = {
      enabled = false,
    },
    terminal = {
      win = {
        position = "float",
        border = "rounded",
        width = 0.9,
        height = 0.9,
      },
    },
  },
}
