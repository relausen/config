return {
  "mfussenegger/nvim-dap",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "ldelossa/nvim-dap-projects",
    "jay-babu/mason-nvim-dap.nvim",
    "mfussenegger/nvim-dap-python",
  },
  config = function ()
    local dap = require("dap")
    local dapui = require("dapui")
    local dap_virtual_text = require("nvim-dap-virtual-text")
    local dap_projects = require('nvim-dap-projects')
    local dap_python = require('dap-python')
    local keymap = vim.keymap

    dapui.setup()
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
    dap_virtual_text.setup({
      commented = true,
    })

    dap_projects.search_project_config()

    local mason_dapconfig = require("mason-nvim-dap")
    local mason_registry = require("mason-registry")

    mason_dapconfig.setup({
      ensure_installed = {
        "bash",
        "codelldb",
        "python",
      },
      automatic_installation = true,
      handlers = {
        --     function(config)
        --         -- all sources with no handler get passed here
        --
        --         -- Keep original functionality
        --         require('mason-nvim-dap').default_setup(config)
        --     end,
        --
        codelldb = function (config)
          local codelldb = mason_registry.get_package("codelldb")
          local extension_path = codelldb:get_install_path() .. "/extension/"
          local codelldb_path = extension_path .. 'adapter/codelldb'
          local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'

          config.adapters = {
            type = "server",
            port = "${port}",
            executable = {
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
    dap_python.setup("~/.virtualenvs/debugpy/bin/python")
    dap_python.test_runner = 'pytest'

    local opts = { noremap = true, silent = true }
    opts.desc = "Toggle breakpoint"
    keymap.set("n", "<leader>b", dap.toggle_breakpoint, opts)
    opts.desc = "Debug Continue"
    keymap.set("n", "<leader>dc", dap.continue, opts)
    opts.desc = "Debug Restart"
    keymap.set("n", "<leader>dR", dap.terminate, opts)
    opts.desc = "Debug Terminate"
    keymap.set("n", "<leader>dT", dap.terminate, opts)
    opts.desc = "Step over"
    keymap.set("n", "<F1>", dap.step_over, opts)
    opts.desc = "Step into"
    keymap.set("n", "<F2>", dap.step_into, opts)
    opts.desc = "Step out"
    keymap.set("n", "<F3>", dap.step_out, opts)
  end,
}
