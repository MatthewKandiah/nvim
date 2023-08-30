local dap = require('dap')
local home = os.getenv('HOME');
dap.adapters.codelldb = {
  type = 'server',
  port = "15231",
  executable = {
    -- absolute path to vscode extension with code lldb debug adapter
    -- os.getenv('HOME') to be OS generic maybe?
    command = home .. '/.local/share/nvim/mason/bin/codelldb',
    args = { "--port", "15231" },
  },
}

-- auto launch debug server
dap.configurations.cpp = {
  {
    type = 'codelldb',
    request = 'launch',
    name = "Launch file",
    program = function()
      return vim.fn.getcwd() .. '/' .. vim.fn.input('Path to executable:\n' .. vim.fn.getcwd() .. '/')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}

dap.configurations.c = dap.configurations.cpp

-- better debugging UI
local dapui = require("dapui")
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

-- virtual text for current values
require('nvim-dap-virtual-text').setup()

vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'dap toggle [b]reakpoint' })
vim.keymap.set('n', '<leader>B', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
  { desc = 'dap set conditional [B]reakpoint' })
vim.keymap.set('n', '<leader>dc', dap.continue, { desc = '[d]ap [c]ontinue' })
vim.keymap.set('n', '<F2>', dap.step_into, { desc = 'dap [s]tep in' })
vim.keymap.set('n', '<F3>', dap.step_over, { desc = 'dap [n]ext' })
vim.keymap.set('n', '<F4>', dap.step_out, { desc = 'dap step [o]ut' })

