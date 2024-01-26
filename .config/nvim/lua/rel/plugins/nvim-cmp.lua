return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp",
    {"L3MON4D3/LuaSnip", build = "make install_jsregexp"},
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
    "PhilRunninger/cmp-rpncalc",
    "onsails/lspkind.nvim",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local lspkind = require("lspkind")

    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-j>"] = cmp.mapping(function(fallback)
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, {"i", "s"}),
        ["<C-k>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, {"i", "s"}),
        ["<C-p>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-n>"] = cmp.mapping.select_next_item(), -- next suggestion
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text",
          menu = ({
            buffer = "[Buffer] ",
            nvim_lsp = "[LSP] ",
            luasnip = "[LuaSnip] ",
            nvim_lua = "[Lua] ",
            path = "[path] ",
          }),
        }),
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = 'luasnip' },
        { name = 'nvim_lua' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'rpncalc' },
      }),
    })
  end
}
