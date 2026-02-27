vim.keymap.set('n', '<leader>ts', ':SupermavenToggle<cr>', { desc = 'Supermaven Toggle' })

return {
  'supermaven-inc/supermaven-nvim',
  opts = {
    -- disable_inline_completion = true, -- disables inline completion for use with cmp
    -- disable_keymaps = true, -- disables built in keymaps for more manual control
    keymaps = {
      accept_suggestion = '<Tab>',
      clear_suggestion = '<c-]>',
      accept_word = '<C-b>',
    },

    ignore_filetypes = {
      'markdown',
      'text',
    },
  },
}
