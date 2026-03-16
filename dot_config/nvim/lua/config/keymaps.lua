-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap

map.set({ "n", "v" }, "æ", [[\]], { remap = true })
map.set({ "n", "v" }, "ø", "[", { remap = true })
map.set({ "n", "v" }, "å", "]", { remap = true })
map.set({ "n", "t", "i" }, "<c-æ>", [[<c-\>]], { remap = true })
map.set({ "n" }, "<c-ø>", "<c-[>")
map.set({ "n" }, "<c-å>", "<c-]>")
map.set("c", "%%", "getcmdtype() == ':' ? expand('%:h').'/' : '%%'", { expr = true })
map.set("", "<leader>fos", ":sp %%", { remap = true, desc = "Open file from buffer dir in horisontal split" })
map.set("", "<leader>fot", ":tabe %%", { remap = true, desc = "Open file from buffer dir in new tab" })
map.set("", "<leader>fov", ":vsp %%", { remap = true, desc = "Open file from buffer dir in vertical split" })
map.set("", "<leader>fow", ":e %%", { remap = true, desc = "Open file from buffer dir in current window" })
-- map.set("n", "n", "nzzzv")
-- map.set("n", "N", "Nzzzv")
map.set("n", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
map.set("v", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
map.set("n", "<leader>Y", '"+Y', { desc = "Copy to system clipboard" })

-- Floating terminal
map.set("n", [[<C-\>]], function()
  Snacks.terminal()
end, { desc = "Floating terminal" })
map.set("t", [[<C-\>]], "<cmd>close<cr>", { desc = "Hide Terminal" })
