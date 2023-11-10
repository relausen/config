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
                    local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/'
                    local codelldb_path = extension_path .. 'adapter/codelldb'
                    local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'

                    print(codelldb_path)

                    config.adapters = {
                        type = "server",
                        port = "${port}",
                        executable = {
                            -- executable = vim.fs.normalize("~/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/adapter/codelldb"),
                            command = codelldb_path,
                            args = { "--liblldb", liblldb_path, "--port", "${port}" },
                        },
                        args = { "--port", "${port}" },
                    }
                    config.configurations.rust = {
                        {
                            name = "Launch file",
                            type = "lldb",
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
