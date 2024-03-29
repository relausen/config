return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-telescope/telescope.nvim",
    -- "mfussenegger/nvim-dap-python"
  },
  event = "VeryLazy",
  opts = {
    parents = 1,
  },
  keys = {
    { "<leader>ves", "<cmd>VenvSelect<cr>" },
    { "<leader>vec", "<cmd>VenvSelectCached<cr>" },
  }
}
