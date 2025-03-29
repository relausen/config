return {
  "folke/snacks.nvim",
  ---@type snacks.Config
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
  },
}
