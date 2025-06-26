if true then
  return {}
end

return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = {},
  keys = {
    { 'H', '<CMD>BufferLineCyclePrev<CR>', desc = 'Buffer previous' },
    { 'L', '<CMD>BufferLineCycleNext<CR>', desc = 'Buffer next' },
    { '<leader>bh', '<CMD>BufferLineMovePrev<CR>', desc = 'Buffer move previous' },
    { '<leader>bl', '<CMD>BufferLineMoveNext<CR>', desc = 'Buffer move next' },
    { '<leader>bo', '<CMD>BufferLineCloseOthers<CR>', desc = 'Close other buffers' },
  },
}
