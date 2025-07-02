return {
  'm4xshen/hardtime.nvim',
  dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
  opts = {
    disable_mouse = false,
    restricted_keys = {
      ['j'] = false,
      ['k'] = false,
    },
    disable_keys = {
      ['<C-N>'] = false,
    },
  },
}
