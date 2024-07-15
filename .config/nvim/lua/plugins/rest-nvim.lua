-- plugins/rest.lua
return {
  "rest-nvim/rest.nvim",
  ft = "http",
  config = function()
    require("rest-nvim").setup({
      keybinds = {
        { "<leader>xr", "<cmd>Rest run<cr>", "Run request under cursor" },
        { "<leader>xl", "<cmd>Rest run last<cr>", "Re-run latest request" },
      },
    })
  end,
}
