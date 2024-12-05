local function find_files_from_project_git_root()
  local function is_git_repo()
    vim.fn.system("git rev-parse --is-inside-work-tree")
    return vim.v.shell_error == 0
  end
  local function get_git_root()
    local dot_git_path = vim.fn.finddir(".git", ".;")
    if dot_git_path == "" then
      dot_git_path = vim.fn.findfile(".git", ".;")
    end
    return vim.fn.fnamemodify(dot_git_path, ":h")
  end
  local opts = {}
  if is_git_repo() then
    opts = {
      cwd = get_git_root(),
    }
  end
  require("telescope.builtin").find_files(opts)
end

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
    local builtin = require("telescope.builtin")
    local actions = require("telescope.actions")

    local search_dir_picker = require("search_dir_picker")

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
        file_browser = {
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = true,
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("search_dir_picker")
    telescope.load_extension("file_browser")
    telescope.load_extension("dap")
    telescope.load_extension("media_files")

    local keymap = vim.keymap
    keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Fuzzy find buffers" })
    keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>ff", find_files_from_project_git_root, { desc = "Fuzzy find files" })
    keymap.set(
      "n",
      "<leader>ffb",
      "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",
      { desc = "Fuzzy file browser" }
    )
    keymap.set("n", "<leader>fgb", builtin.git_branches, { desc = "Fuzzy find git branches" })
    keymap.set("n", "<leader>fgc", builtin.git_commits, { desc = "Fuzzy find git commits" })
    keymap.set("n", "<leader>fgs", builtin.git_status, { desc = "Fuzzy find git status" })
    keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Fuzzy find help" })
    keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Fuzzy find key mappings" })
    keymap.set("n", "<leader>fl", function()
      builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "Fuzzy find Neovim config" })
    keymap.set("n", "<leader>fm", builtin.man_pages, { desc = "Fuzzy find manpages" })
    keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Find string in cwd" })
    keymap.set("n", "<leader>ft", builtin.treesitter, { desc = "Find from treesitter" })
    keymap.set("n", "<leader>fu", builtin.reloader, { desc = "Reload" })

    local extensions = telescope.extensions
    keymap.set("n", "<leader>fn", extensions.notify.notify, { desc = "Fuzzy find notification history" })
    keymap.set("n", "<leader>fdb", extensions.dap.list_breakpoints, { desc = "Fuzzy find breakpoints" })
    keymap.set("n", "<leader>fdc", extensions.dap.commands, { desc = "Fuzzy find DAP commands" })
    keymap.set("n", "<leader>fdv", extensions.dap.variables, { desc = "Fuzzy find DAP variables" })

    keymap.set("n", "<leader>fsd", search_dir_picker.search_dir, { desc = "Set search dir" })
  end,
}
