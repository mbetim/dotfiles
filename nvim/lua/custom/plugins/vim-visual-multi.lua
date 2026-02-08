return {
  'mg979/vim-visual-multi',
  event = { 'BufReadPre', 'BufNewFile' },
  init = function()
    vim.g.VM_maps = {
      ['Goto Prev'] = '[n',
      ['Goto Next'] = ']n',
      ['Select Cursor Down'] = '<M-Down>',
      ['Select Cursor Up'] = '<M-Up>',
    }
    vim.keymap.set('n', '<C-n>', '<Plug>(VM-Find-Under)')
  end,
  lazy = false,
}
