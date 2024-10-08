local options = {
  background = "dark",
  backspace = { "indent", "eol", "start" },
  backup = false,
  cursorline = true,
  expandtab = true,
  fileencoding = "utf-8",
  hidden = true,
  hlsearch = true,
  ignorecase = true,
  inccommand = "split",
  incsearch = true,
  laststatus = 2,
  mouse = "",
  number = true,
  pumheight = 20,
  relativenumber = true,
  ruler = true,
  scrolloff = 2,
  shiftwidth = 4,
  showmode = false,
  showtabline = 2,
  sidescrolloff = 2,
  signcolumn = "yes",
  smartcase = true,
  smartindent = true,
  softtabstop = 4,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  tabstop = 4,
  termguicolors = true,
  ttimeoutlen = 50,
  undodir = os.getenv("HOME") .. "/.vim/tmp/undo.nvim",
  undofile = true,
  wildmode = { "longest", "list", "full" },
  wrap = false,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.iskeyword:append("-")
vim.notify = require("notify")

vim.filetype.add({
  extension = {
    tf = "terraform",
  },
})
