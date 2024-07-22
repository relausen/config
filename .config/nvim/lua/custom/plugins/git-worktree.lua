return {
  "ThePrimeagen/git-worktree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "ThePrimeagen/git-worktree.nvim",
  },
  config = function()
    -- local git_worktree = require("git-worktree")
    local telescope = require("telescope")

    -- git_worktree.setup({
    --   change_directory_command = "tcd",
    -- })

    telescope.load_extension("git_worktree")

    vim.keymap.set("n", "<leader>gwtl", require('telescope').extensions.git_worktree.git_worktrees, { noremap = true, silent = true, desc = "List git worktrees" })
    vim.keymap.set("n", "<leader>gwtc", require('telescope').extensions.git_worktree.create_git_worktree, { noremap = true, silent = true, desc = "Create git worktree" })
  end,
}
