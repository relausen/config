return {
  "hrsh7th/cmp-cmdline",
  event = "VeryLazy",
  config = function()
    local cmp = require("cmp")
    cmp.setup.cmdline(':', {
      -- mapping = cmp.mapping.preset.cmdline(),
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        {
          name = 'cmdline',
          option = {
            ignore_cmds = { 'Man', '!' }
          }
        }
      })
    })
    -- `/` cmdline setup.
    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })
  end,
}
