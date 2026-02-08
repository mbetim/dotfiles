vim.g.copilot_filetypes = { markdown = false }
vim.keymap.set('i', '<C-]>', '<Plug>(copilot-accept-word)', { desc = 'Accept Copilot suggestion' })

return {
  'github/copilot.vim',
}
