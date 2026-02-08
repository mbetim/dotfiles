return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup {
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
        -- Use tab-local cwd for harpoon key, enabling per-tab project lists
        key = function()
          return vim.fn.getcwd(-1, 0)
        end,
      },
    }

    vim.keymap.set('n', '<leader>hm', function()
      harpoon:list():add()
    end, { desc = 'Mark file with harpoon' })

    vim.keymap.set('n', '<leader>hf', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Mark file with harpoon' })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<leader>hh', function()
      harpoon:list():prev()
    end)
    vim.keymap.set('n', '<leader>hl', function()
      harpoon:list():next()
    end)

    for i = 1, 5 do
      vim.keymap.set('n', '<leader>' .. i, function()
        harpoon:list():select(i)
      end, { desc = 'Harpoon to File ' .. i })
    end
  end,
}
