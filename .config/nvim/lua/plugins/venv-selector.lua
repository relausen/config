return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-telescope/telescope.nvim",
    -- "mfussenegger/nvim-dap-python"
  },
  lazy = false,
  branch = "regexp",
  opts = {
    parents = 1,
  },
  keys = {
    { "<leader>ves", "<cmd>VenvSelect<cr>" },
    { "<leader>vec", "<cmd>VenvSelectCached<cr>" },
  },
}
