if true then
  return {}
end

vim.keymap.set('n', '<leader>ts', ':SupermavenToggle<cr>', { desc = 'Supermaven Toggle' })

return {
  'supermaven-inc/supermaven-nvim',
  dependencies = {
    'huijiro/blink-cmp-supermaven',
  },
  opts = {
    -- disable_inline_completion = true, -- disables inline completion for use with cmp
    -- disable_keymaps = true, -- disables built in keymaps for more manual control
    keymaps = {
      accept_suggestion = '<Tab>',
      clear_suggestion = '<C-]>',
      accept_word = '<C-e>',
    },

    ignore_filetypes = {
      'markdown',
      'text',
    },
  },
}
