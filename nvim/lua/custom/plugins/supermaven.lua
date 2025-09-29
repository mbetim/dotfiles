return {
  'supermaven-inc/supermaven-nvim',
  dependencies = {
    'huijiro/blink-cmp-supermaven',
  },
  opts = {
    disable_inline_completion = true, -- disables inline completion for use with cmp
    disable_keymaps = true, -- disables built in keymaps for more manual control
    ignore_filetypes = {
      'markdown',
    },
  },
}
