return {
  'sindrets/diffview.nvim',
  keys = {
    { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Open diff view' },
    { '<leader>gc', '<cmd>DiffviewClose<cr>', desc = 'Close diff view' },
    { '<leader>gm', '<cmd>DiffviewOpen origin/main...HEAD<cr>', desc = 'Compare with origin main' },
  },
}
