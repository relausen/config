local telescope = require("telescope")
local builtin = require('telescope.builtin')
local search_dir_picker = require("search_dir_picker")
local keymap = vim.keymap
keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find files in cwd" })
keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Fuzzy find help" })
keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Fuzzy find buffers" })
keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Find string in cwd" })
keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "Find string under cursor in cwd" })
keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Fuzzy find recent files" })

local extensions = telescope.extensions
keymap.set("n", "<leader>fdb", extensions.dap.list_breakpoints, { desc = "Fuzzy find breakpoints" })
keymap.set("n", "<leader>fdc", extensions.dap.commands, { desc = "Fuzzy find DAP commands" })
keymap.set("n", "<leader>fdv", extensions.dap.variables, { desc = "Fuzzy find DAP variables" })

keymap.set("n", "<leader>fsd", search_dir_picker.search_dir, { desc = "Set search dir" })
