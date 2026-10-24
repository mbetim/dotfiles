return {
  'chrisgrieser/nvim-chainsaw',
  event = 'VeryLazy',
  opts = {}, -- required even if left empty
  keys = {
    {
      '<leader>ll',
      function()
        require('chainsaw').variableLog()
      end,
      desc = 'Log var',
    },
    {
      '<leader>lo',
      function()
        require('chainsaw').objectLog()
      end,
      desc = 'Log object',
    },
    {
      '<leader>lr',
      function()
        require('chainsaw').removeLogs()
      end,
      desc = 'Remove all logs',
    },
    {
      '<C-g><C-g>',
      function()
        require('chainsaw').messageLog()
      end,
      desc = 'New log',
      mode = { 'i', 'n' },
    },
  },
}
