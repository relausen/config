return {
  "letieu/wezterm-move.nvim",
  cond = function()
    return vim.fn.exists("$TMUX") == 0 and true or false
  end,
  keys = {
    {
      "<C-h>",
      function()
        require("wezterm-move").move("h")
      end,
    },
    {
      "<C-j>",
      function()
        require("wezterm-move").move("j")
      end,
    },
    {
      "<C-k>",
      function()
        require("wezterm-move").move("k")
      end,
    },
    {
      "<C-l>",
      function()
        require("wezterm-move").move("l")
      end,
    },
  },
}
