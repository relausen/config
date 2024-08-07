return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local nvimtree = require("nvim-tree")

    nvimtree.setup({
      hijack_netrw = false,
      renderer = {
        indent_markers = {
          enable = true,
        },
        -- icons = {
        --   glyphs = {
        --     folder = {
        --       arrow_closed = "", -- arrow when folder is closed
        --       arrow_open = "", -- arrow when folder is open
        --     },
        --   },
        -- },
      },
      filters = {
        custom = { ".DS_Store" },
      },
    })
  end,
  keys = {
    { "<leader>ee", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" }, -- toggle file explorer
    { "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", desc = "Toggle file explorer on current file" }, -- toggle file explorer on current file
    { "<leader>ec", "<cmd>NvimTreeCollapse<CR>", desc = "Collapse file explorer" }, -- collapse file explorer
    { "<leader>er", "<cmd>NvimTreeRefresh<CR>", desc = "Refresh file explorer" }, -- refresh file explorer
  },
}
