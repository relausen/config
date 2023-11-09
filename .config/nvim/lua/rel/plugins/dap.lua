return {
    'mfussenegger/nvim-dap',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "ldelossa/nvim-dap-projects",
    },
    config = function ()
        local dap = require("dap")
        local dapui = require("dapui")
        local dap_virtual_text = require("nvim-dap-virtual-text")
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
        require('nvim-dap-projects').search_project_config()


        local opts = { noremap = true, silent = true }
        keymap.set("n", "<leader>b", dap.toggle_breakpoint, opts)
        keymap.set("n", "<leader>dc", dap.continue, opts)
        keymap.set("n", "<leader>do", dap.step_over, opts)
        keymap.set("n", "<leader>di", dap.step_into, opts)

        vim.opt["mouse"] = "a"
    end,
}
