-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- local wezterm = require("config.wezterm-support")

vim.g.lazyvim_python_lsp = "basedpyright"

vim.opt.clipboard = ""
vim.opt.iskeyword:append("-")
-- vim.opt.langremap = true
-- vim.opt.langmap = "æ\\[,ø],å\\\\"
-- vim.opt.langmap = "æøå;[]\\\\"
vim.opt.laststatus = 2
vim.opt.mouse = ""

vim.filetype.add({
  filename = {
    ["devcontainer.json"] = "jsonc",
  },
})
