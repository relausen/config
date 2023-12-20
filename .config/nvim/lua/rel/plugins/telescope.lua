return {
  'nvim-telescope/telescope.nvim',
  tag = "0.1.5",
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    "nvim-telescope/telescope-dap.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-tree/nvim-web-devicons",
    "smilovanovic/telescope-search-dir-picker.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.load_extension("fzf")
    telescope.load_extension("search_dir_picker")
    telescope.load_extension("file_browser")
    telescope.load_extension("dap")
    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          }
        }
      },
    })
  end
}
