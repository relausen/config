return {
  "neovim/nvim-lspconfig",
  event = "LazyFile",
  dependencies = {
    "mason.nvim",
    { "williamboman/mason-lspconfig.nvim", config = function() end },
  },
  opts = {
    servers = {
      basedpyright = {
        settings = {
          basedpyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
            analysis = {
              diagnosticSeverityOverrides = {
                reportAny = false,
              },
              --   -- Ignore all files for analysis to exclusively use Ruff for linting
              ignore = { "*" },
            },
          },
        },
      },
    },
  },
}
