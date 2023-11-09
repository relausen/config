return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        -- "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_dapconfig = require("mason-nvim-dap")

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

        mason_dapconfig.setup({
            ensure_installed = {
                "codelldb",
            },
            automatic_installation = true,
            handlers = {
                codelldb = function (config)
                    config.adapters = {
                        type = "server",
                        port = "${port}",
                        executable = {
                            command = vim.fs.normalize("~/.local/share/codelddb/extension/adapter/codelldb"),
                            args = { "--port", "${port}" },
                        }
                    }
                    config.configurations.rust = {
                        {
                            name = "Launch file",
                            type = "codelldb",
                            request = "launch",
                            program = function()
                                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                            end,
                            cwd = '${workspaceFolder}',
                            stopOnEntry = false,
                        }
                    }
                    require('mason-nvim-dap').default_setup(config)
                end
            }
        })
    end,
}
