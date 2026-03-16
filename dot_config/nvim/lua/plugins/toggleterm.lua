M = {
  "akinsho/toggleterm.nvim",
  version = "*",
  enabled = false,
}

local open_key = [[<C-\>]]
M.keys = {
  open_key,
}
M.opts = {
  open_mapping = open_key,
  size = 60,
  direction = "float",
  shade_terminals = true,
}

return M
