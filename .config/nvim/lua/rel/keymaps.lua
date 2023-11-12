local map = vim.keymap

map.set({ "n", "v" }, "æ", "[")
map.set({ "n", "v" }, "ø", "]")
map.set({ "n", "t", "i" }, "<C-æ>", "<C-\\>", { remap = true})
map.set({ "n" }, "<C-ø>", "<C-[>")
map.set({ "n" }, "<C-å>", "<C-]>")
map.set("n", "<leader>nh", "<cmd>nohlsearch<CR>")
map.set("c", "%%", "getcmdtype() == ':' ? expand('%:h').'/' : '%%'", { expr = true })
map.set("", "<leader>es", ":sp %%", { remap = true })
map.set("", "<leader>et", ":tabe %%", { remap = true })
map.set("", "<leader>ev", ":vsp %%", { remap = true })
map.set("", "<leader>ew", ":e %%", { remap = true })
map.set("n", "n", "nzzzv")
map.set("n", "N", "Nzzzv")
map.set("n", "<leader>y", "\"+y")
map.set("v", "<leader>y", "\"+y")
map.set("n", "<leader>Y", "\"+Y")
map.set("n", "<leader>Gs", "<cmd>G<CR>")
map.set("n", "<leader>Gt", "<cmd>tab G<CR>")
map.set("n", "<leader>Gv", "<cmd>vert G<CR>")
map.set("n", "<leader>Ts", "<cmd>term<CR>")
map.set("n", "<leader>Tt", "<cmd>tabnew | term<CR>")
map.set("n", "<leader>Tv", "<cmd>vs | term<CR>")
map.set("t", "<leader>e", "<C-\\>")
-- map.set("t", "<C-W>", "<C-\\>")
map.set("t", "<Esc>", "<C-\\><C-N>")
