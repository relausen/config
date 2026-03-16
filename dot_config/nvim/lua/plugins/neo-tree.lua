return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      mappings = {
        ["<cr>"] = "open_with_window_picker",
        ["S"] = "split_with_window_picker",
        ["s"] = "vsplit_with_window_picker",
      },
    },
    filesystem = {
      filtered_items = {
        always_show = {
          ".github",
          ".gitignore",
          ".devcontainer",
        },
      },
    },
  },
}
