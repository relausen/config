vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.keymap.set("n", "j", "v:count > 4 ? 'm' . v:count . 'j' : 'gj'", { expr = true })
vim.keymap.set("n", "k", "v:count > 4 ? 'm' . v:count . 'k' : 'gk'", { expr = true })
