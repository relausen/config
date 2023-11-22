return {
	-- "EdenEast/nightfox.nvim",
  "folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		-- vim.cmd("colorscheme nightfox")
    require("tokyonight").setup({
      style = "night",
      dim_inactive = true,
      lualine_bold = true,
    })
		vim.cmd("colorscheme tokyonight")
	end,
}
