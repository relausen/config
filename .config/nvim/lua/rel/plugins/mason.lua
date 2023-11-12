return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        -- local mason_dapconfig = require("mason-nvim-dap")

        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                }
            }
        })

        mason_lspconfig.setup({
            ensure_installed = {
                "lua_ls",
                "pyright",
                "ruff_lsp",
                "rust_analyzer",
                "terraformls",
            },
            automatic_installation = true,
        })
    end,
}
