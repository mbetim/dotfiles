return {
  'mg979/vim-visual-multi',
  event = 'VeryLazy',
  init = function()
    vim.g.VM_maps = {
      ['Goto Prev'] = '[n',
      ['Goto Next'] = ']n',
      ['Select Cursor Down'] = '<M-Down>',
      ['Select Cursor Up'] = '<M-Up>',
    }
  end,
}
