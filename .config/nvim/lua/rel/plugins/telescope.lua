return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-dap.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-media-files.nvim",
    "nvim-tree/nvim-web-devicons",
    "smilovanovic/telescope-search-dir-picker.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-h>"] = "which_key",
          },
        },
      },
      extensions = {
        media_files = {
          filetypes = { "png", "jpg", "jpeg", "mp4", "webm", "pdf" },
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("search_dir_picker")
    telescope.load_extension("file_browser")
    telescope.load_extension("dap")
    telescope.load_extension("media_files")
  end,
}
