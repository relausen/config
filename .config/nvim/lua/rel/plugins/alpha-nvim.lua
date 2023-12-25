return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Set header
    dashboard.section.header.val = {
[[      _____                                                  _____                                      ]],
[[   __|___  |__  _____   _____  __  __  ______  ____   _   __|___  |__  _____   ____    ____  ____   _   ]],
[[  |      >    ||     | /     \|  |/ / |   ___||    \ | | |      >    ||     | |    \  |    ||    \ | |  ]],
[[  |     <     ||     \ |     ||     \ |   ___||     \| | |     <     ||     \ |     \ |    ||     \| |  ]],
[[  |______>  __||__|\__\\_____/|__|\__\|______||__/\____| |______>  __||__|\__\|__|\__\|____||__/\____|  ]],
[[     |_____|                                                |_____|                                     ]],
[[                                                                                                        ]],
    }

    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button("e", "  > New File", "<cmd>enew<CR>"),
      dashboard.button("l", "💤  > Lazy", "<cmd>Lazy<CR>"),
      dashboard.button("m", "🪬  > Mason", "<cmd>Mason<CR>"),
      -- dashboard.button("p", "  > Projects", "<cmd>Telescope <CR>"),
    --   dashboard.button("SPC ff", "󰱼 > Find File", "<cmd>Telescope find_files<CR>"),
    --   -- dashboard.button("SPC fs", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
    --   dashboard.button("SPC wr", "󰁯  > Restore Session For Current Directory", "<cmd>SessionRestore<CR>"),
      dashboard.button("q", " > Quit Neovim", "<cmd>qa<CR>"),
    }

    dashboard.section.footer.val = require("alpha.fortune")()

    -- Send config to alpha
    alpha.setup(dashboard.config)

    -- Disable folding on alpha buffer
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
