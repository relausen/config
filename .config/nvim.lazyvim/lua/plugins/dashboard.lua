return {
  "snacks.nvim",
  opts = function(_, opts)
    opts.dashboard.preset.header = [[
            _____                                                  _____                                    
         __|___  |__  _____   _____  __  __  ______  ____   _   __|___  |__  _____   ____    ____  ____   _ 
        |      >    ||     | /     \|  |/ / |   ___||    \ | | |      >    ||     | |    \  |    ||    \ | |
        |     <     ||     \ |     ||     \ |   ___||     \| | |     <     ||     \ |     \ |    ||     \| |
        |______>  __||__|\__\\_____/|__|\__\|______||__/\____| |______>  __||__|\__\|__|\__\|____||__/\____|
           |_____|                                                |_____|                                   
                                                                                                            
                                              A Dark and Haunted Place                                      
         ]]
    table.insert(
      opts.dashboard.preset.keys,
      8,
      { icon = "", key = "S", desc = "Select Session", action = require("persistence").select }
    )
    table.insert(opts.dashboard.preset.keys, 11, { icon = "", key = "m", desc = "Mason", action = ":Mason" })
  end,
}
