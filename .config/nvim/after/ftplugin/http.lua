local map = vim.keymap

map.set("n", "<leader>xr", "<Plug>RestNvim", { silent = true, buffer = true })
map.set("n", "<leader>xp", "<Plug>RestNvimPreview", { silent = true, buffer = true })
map.set("n", "<leader>xl", "<Plug>RestNvimLast", { silent = true, buffer = true })
