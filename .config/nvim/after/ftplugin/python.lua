-- vim.g.pyindent_open_paren = 'shiftwidth()'
-- vim.g.pyindent_continue = 'shiftwidth()'

local keymap = vim.keymap
local dap_python = require('dap-python')

local opts = { noremap = true, silent = true }

opts.desc = "Run test method/function"
keymap.set("n", "<leader>dm", dap_python.test_method, opts)

opts.desc = "Run test class"
keymap.set("n", "<leader>dC", dap_python.test_class, opts)

opts.desc = "Debug selection"
keymap.set("n", "<leader>ds", dap_python.debug_selection, opts)
