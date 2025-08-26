return {
  'stevearc/overseer.nvim',
  opts = {
    task_list = {
      bindings = {
        ['<S-u>'] = 'ScrollOutputUp',
        ['<S-d>'] = 'ScrollOutputDown',
        ['<S-k>'] = 'ScrollOutputUp',
        ['<S-j>'] = 'ScrollOutputDown',
        ['<C-j>'] = false,
        ['<C-k>'] = false,
      },
    },
  },
  keys = {
    {
      '<leader>or',
      '<cmd>OverseerRun<cr>',
      desc = 'Overseer Run',
    },
    {
      '<leader>oo',
      '<cmd>OverseerToggle<cr>',
      desc = 'Overseer Toggle',
    },
  },
}
