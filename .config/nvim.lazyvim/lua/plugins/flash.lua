local M = {
  "folke/flash.nvim",
  keys = {
    {
      "<leader>sfj",
      mode = { "n", "x" },
      function()
        require("flash").jump()
      end,
      desc = "Jump",
    },
    {
      "<leader>sft",
      mode = { "n", "x" },
      function()
        require("flash").treesitter()
      end,
      desc = "Treesitter",
    },
    {
      "<leader>sfT",
      mode = { "x" },
      function()
        require("flash").treesitter_search()
      end,
      desc = "Treesitter Search",
    },
    {
      "s",
      mode = { "n", "x" },
      false,
    },
    {
      "S",
      mode = { "n", "x" },
      false,
    },
    {
      "R",
      mode = { "x" },
      false,
    },
  },
}

local wk = require("which-key")
wk.add({
  { "<leader>sf", mode = { "n", "x" }, group = "Flash" }, -- group
})

return M
