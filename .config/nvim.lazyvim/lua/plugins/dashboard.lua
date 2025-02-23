return {
  "snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        header = [[
            _____                                                  _____                                    
         __|___  |__  _____   _____  __  __  ______  ____   _   __|___  |__  _____   ____    ____  ____   _ 
        |      >    ||     | /     \|  |/ / |   ___||    \ | | |      >    ||     | |    \  |    ||    \ | |
        |     <     ||     \ |     ||     \ |   ___||     \| | |     <     ||     \ |     \ |    ||     \| |
        |______>  __||__|\__\\_____/|__|\__\|______||__/\____| |______>  __||__|\__\|__|\__\|____||__/\____|
           |_____|                                                |_____|                                   
                                                                                                            
                                              A Dark and Haunted Place                                        
         ]],
        -- stylua: ignore
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":enew | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = "", key = "m", desc = "Mason", action = ":Mason" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
  },
}
