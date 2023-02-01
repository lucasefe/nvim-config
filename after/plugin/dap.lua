local dap = require('dap')

dap.set_log_level('TRACE')

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/.local/share/nvim/mason/packages/node-debug2-adapter/out/src/nodeDebug.js'},
}

dap.configurations.javascript = {
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    name = 'Run with mocha',
    type = 'node2',
    request = 'launch',
    program = '${workspaceFolder}/node_modules/.bin/mocha',
    runtimeArgs = { '--inspect-brk', '${relativeFile}' },
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
    port = 9229
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = require'dap.utils'.pick_process,
  },
}

require("dapui").setup()

require("neodev").setup({
  library = { plugins = { "nvim-dap-ui" }, types = true },
})

vim.keymap.set('n', '<leader>dk', function() require('dap').continue() end, {silent = true, noremap = true, desc = 'DAP Continue'})
vim.keymap.set('n', '<leader>dl', function() require('dap').run_last() end,   {silent = true, noremap = true, desc = 'DAP Run Last'})
vim.keymap.set('n', '<leader>db', function() require('dap').toggle_breakpoint() end,   {silent = true, noremap = true, desc = 'DAP Toggle Breakpoint'})

vim.keymap.set('n', '<leader>do', function() require("dapui").open()  end, {silent = true, noremap = true, desc = 'DAP UI Open'})
vim.keymap.set('n', '<leader>dc', function() require("dapui").close()  end, {silent = true, noremap = true, desc = 'DAP UI Close'})
vim.keymap.set('n', '<leader>dt', function() require("dapui").toggle()  end, {silent = true, noremap = true, desc = 'DAP UI Toggle' })

