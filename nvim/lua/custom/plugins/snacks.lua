return {
  'folke/snacks.nvim',
  lazy = false,
  priority = 1000,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    scroll = { enabled = false },
    lazygit = { enabled = true },
    bufdelete = { enabled = true },
    indent = { enabled = true },
    image = { enabled = false, doc = { inline = false } },
    picker = {
      hidden = true,
      matcher = {
        frecency = true,
      },
      formatters = {
        file = {
          filename_first = true,
          ---@type "left"|"center"|"right"
          truncate = 'left',
          min_width = 50, -- minimum length of the truncated path
        },
      },
      debug = {
        scores = false,
      },
      win = {
        input = {
          keys = {
            ['<CR>'] = { 'confirm', mode = { 'i', 'n' } },
            ['<C-y>'] = { 'confirm', mode = { 'i', 'n' } },
            ['J'] = { 'preview_scroll_down', mode = { 'n' } },
            ['K'] = { 'preview_scroll_up', mode = { 'n' } },
            ['H'] = { 'preview_scroll_left', mode = { 'n' } },
            ['L'] = { 'preview_scroll_right', mode = { 'n' } },
            ['M'] = { 'toggle_hidden', mode = { 'n' } },
            ['d'] = { 'bufdelete', mode = { 'n' } },
          },
        },
      },
    },
    dashboard = {
      preset = {
        keys = {
          { icon = ' ', key = 'f', desc = 'Find File', action = ':lua Snacks.picker.files()' },
          {
            icon = ' ',
            key = 'r',
            desc = 'Recent Files',
            action = ":lua Snacks.dashboard.pick('oldfiles')",
          },
          { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
          {
            icon = '󰒲 ',
            key = 'L',
            desc = 'Lazy',
            action = ':Lazy',
            enabled = package.loaded.lazy ~= nil,
          },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
      },
      sections = {
        { section = 'header' },
        { icon = ' ', title = 'Keymaps', section = 'keys', indent = 2, padding = 1 },
        {
          icon = ' ',
          title = 'Recent Files',
          section = 'recent_files',
          cwd = true,
          indent = 2,
          padding = 1,
        },
        { section = 'startup' },
      },
    },
  },
  keys = function()
    local Snacks = require 'snacks'
    return {
      {
        '<leader><space>',
        function()
          Snacks.picker.files()
        end,
        desc = 'Find Files',
      },
      {
        '<leader>/',
        function()
          Snacks.picker.grep()
        end,
        desc = 'Grep',
      },
      {
        '<leader>:',
        function()
          Snacks.picker.command_history()
        end,
        desc = 'Command History',
      },
      {
        '<leader>n',
        function()
          Snacks.picker.notifications()
        end,
        desc = 'Notification History',
      },
      -- find
      {
        '<leader>ff',
        function()
          Snacks.picker.files()
        end,
        desc = 'Find Files',
      },
      {
        '<leader>fr',
        function()
          Snacks.picker.recent()
        end,
        desc = 'Recent',
      },
      -- git
      {
        '<leader>gl',
        function()
          Snacks.picker.git_log_file()
        end,
        desc = 'Git Log File',
      },
      {
        '<leader>gL',
        function()
          Snacks.picker.git_log_line()
        end,
        desc = 'Git Log Line',
      },
      {
        '<leader>fs',
        function()
          Snacks.picker.git_status()
        end,
        desc = 'Find Git Status',
      },
      -- Grep
      {
        '<leader>sb',
        function()
          Snacks.picker.buffers()
        end,
        desc = 'Buffer',
      },
      {
        '<leader>sB',
        function()
          Snacks.picker.grep_buffers()
        end,
        desc = 'Grep Open Buffers',
      },
      {
        '<leader>sw',
        function()
          Snacks.picker.grep_word()
        end,
        desc = 'Visual selection or word',
        mode = { 'n', 'x' },
      },
      -- search
      {
        '<leader>s/',
        function()
          Snacks.picker.search_history()
        end,
        desc = 'Search History',
      },
      {
        '<leader>sc',
        function()
          Snacks.picker.commands()
        end,
        desc = 'Commands',
      },
      {
        '<leader>sd',
        function()
          Snacks.picker.diagnostics()
        end,
        desc = 'Diagnostics',
      },
      {
        '<leader>sD',
        function()
          Snacks.picker.diagnostics_buffer()
        end,
        desc = 'Buffer Diagnostics',
      },
      {
        '<leader>sh',
        function()
          Snacks.picker.help()
        end,
        desc = 'Help Pages',
      },
      -- {
      --   '<leader>sH',
      --   function()
      --     Snacks.picker.highlights()
      --   end,
      --   desc = 'Highlights',
      -- },
      {
        '<leader>si',
        function()
          Snacks.picker.icons()
        end,
        desc = 'Icons',
      },
      {
        '<leader>sj',
        function()
          Snacks.picker.jumps()
        end,
        desc = 'Jumps',
      },
      {
        '<leader>sk',
        function()
          Snacks.picker.keymaps()
        end,
        desc = 'Keymaps',
      },
      {
        '<leader>sl',
        function()
          Snacks.picker.loclist()
        end,
        desc = 'Location List',
      },
      {
        '<leader>sm',
        function()
          Snacks.picker.marks()
        end,
        desc = 'Marks',
      },
      {
        '<leader>sq',
        function()
          Snacks.picker.qflist()
        end,
        desc = 'Quickfix List',
      },
      {
        '<leader>sr',
        function()
          Snacks.picker.resume()
        end,
        desc = 'Resume',
      },
      {
        '<leader>su',
        function()
          Snacks.picker.undo()
        end,
        desc = 'Undo History',
      },
      {
        '<leader>uC',
        function()
          Snacks.picker.colorschemes()
        end,
        desc = 'Colorschemes',
      },
      -- LSP
      {
        'gd',
        function()
          Snacks.picker.lsp_definitions()
        end,
        desc = 'Goto Definition',
      },
      {
        'gD',
        function()
          Snacks.picker.lsp_declarations()
        end,
        desc = 'Goto Declaration',
      },
      {
        'grr',
        function()
          Snacks.picker.lsp_references()
        end,
        nowait = true,
        desc = 'References',
      },
      {
        'gI',
        function()
          Snacks.picker.lsp_implementations()
        end,
        desc = 'Goto Implementation',
      },
      {
        'gy',
        function()
          Snacks.picker.lsp_type_definitions()
        end,
        desc = 'Goto T[y]pe Definition',
      },
      {
        '<leader>ss',
        function()
          Snacks.picker.lsp_symbols()
        end,
        desc = 'LSP Symbols',
      },
      {
        '<leader>sS',
        function()
          Snacks.picker.lsp_workspace_symbols()
        end,
        desc = 'LSP Workspace Symbols',
      },
      {
        '<leader>gg',
        function()
          Snacks.lazygit()
        end,
        desc = 'Lazygit',
      },
      {
        '<leader>bd',
        function()
          Snacks.bufdelete()
        end,
        desc = 'Delete Buffer',
      },
      {
        '<leader>sp',
        function()
          local root = vim.fs.root(0, '.git') or vim.fn.getcwd()
          local fdcommand = io.popen('fd -t f "^package\\.json$" --exclude node_modules "' .. root .. '" 2>/dev/null')

          if not fdcommand then
            vim.notify('Failed to run fd', vim.log.levels.ERROR)
            return
          end

          local result = fdcommand:read '*a'
          fdcommand:close()

          local items = {}
          for line in result:gmatch '[^\n]+' do
            local dir = vim.fn.fnamemodify(line, ':h')
            local relative = string.gsub(dir, '^' .. vim.pesc(root) .. '/', '')

            -- Skip root directory if it matches
            if dir ~= root then
              table.insert(items, { text = relative, file = dir })
            end
          end

          -- Also add root if it has package.json
          if vim.fn.filereadable(root .. '/package.json') == 1 then
            table.insert(items, 1, { text = '(root)', file = root })
          end

          if #items == 0 then
            vim.notify('No projects found', vim.log.levels.WARN)
            return
          end

          -- Helper function to switch project and reinitialize harpoon
          local function switch_project(picker, item, callback)
            picker:close()
            -- Use tcd (tab-local cd) to allow per-tab project directories
            vim.cmd('tcd ' .. vim.fn.fnameescape(item.file))
            vim.notify('Switched to: ' .. item.text, vim.log.levels.INFO)

            -- Reinitialize Harpoon's data layer to load from the correct file
            vim.schedule(function()
              local ok, harpoon = pcall(require, 'harpoon')
              if ok then
                local Data = require 'harpoon.data'
                harpoon.data = Data.Data:new(harpoon.config)
                harpoon.lists = {} -- Clear cached lists to force reload
              end

              -- Execute callback after harpoon is reinitialized
              if callback then
                vim.defer_fn(callback, 50)
              end
            end)
          end

          Snacks.picker {
            title = 'Switch Project (<CR> Harpoon, <C-f> Files, <C-s> Session)',
            items = items,
            format = function(item)
              return { { item.text } }
            end,
            win = {
              input = {
                keys = {
                  ['<C-f>'] = { 'confirm_files', mode = { 'i', 'n' } },
                  ['<C-s>'] = { 'confirm_session', mode = { 'i', 'n' } },
                },
              },
            },
            actions = {
              confirm_files = function(picker, item)
                switch_project(picker, item, function()
                  Snacks.picker.files()
                end)
              end,
              confirm_session = function(picker, item)
                switch_project(picker, item, function()
                  local persistence_ok, persistence = pcall(require, 'persistence')
                  if persistence_ok then
                    persistence.load()
                  else
                    vim.notify('persistence.nvim not available', vim.log.levels.WARN)
                  end
                end)
              end,
            },
            confirm = function(picker, item)
              switch_project(picker, item, function()
                local harpoon_ok, harpoon = pcall(require, 'harpoon')
                if harpoon_ok then
                  harpoon.ui:toggle_quick_menu(harpoon:list())
                else
                  -- Fallback to files if harpoon not available
                  Snacks.picker.files()
                end
              end)
            end,
          }
        end,
        desc = 'Switch Project',
      },
    }
  end,
}
