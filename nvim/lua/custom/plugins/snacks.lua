return {
  'folke/snacks.nvim',
  lazy = false,
  priority = 1000,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    scroll = { enabled = false },
    lazygit = { enabled = false },
    bufdelete = { enabled = true },
    indent = {
      enabled = true,
      scope = { underline = true },
    },
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

            ['<c-h>'] = { 'toggle_hidden', mode = { 'i', 'n' } },
            ['<c-i>'] = { 'toggle_ignored', mode = { 'i', 'n' } },
            ['<c-w>m'] = { 'toggle_maximize', mode = { 'i', 'n' } },
            ['<c-w><c-w>'] = { 'cycle_win', mode = { 'i', 'n' } },
          },
        },
      },
    },
    dashboard = {
      enabled = false,
      preset = {
        keys = {
          { icon = ' ', key = 'f', desc = 'Find File', action = ':lua Snacks.picker.files()' },
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
          Snacks.picker.smart { filter = { cwd = true } }
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
          -- Scope the status to the project of the current tab (set by <leader>p via tcd),
          -- falling back to the whole repo when the tab cwd is the git root itself.
          local cwd = vim.fn.getcwd()
          local root = vim.fs.root(cwd, '.git')
          local cmd_args = (root and vim.fs.normalize(root) ~= vim.fs.normalize(cwd)) and { '--', cwd } or nil
          Snacks.picker.git_status { cmd_args = cmd_args }
        end,
        desc = 'Find Git Status (project)',
      },
      {
        '<leader>fS',
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
        '<leader>,',
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
        '<leader>bd',
        function()
          Snacks.bufdelete()
        end,
        desc = 'Delete Buffer',
      },
      {
        '<leader>sa',
        function()
          Snacks.picker.pickers()
        end,
        desc = 'All Pickers',
      },
      {
        '<leader>p',
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

          -- Find a tab whose tab-local cwd already points at the given directory
          local function find_project_tab(dir)
            local target = vim.fn.fnamemodify(dir, ':p'):gsub('/$', '')
            for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
              local tabnr = vim.api.nvim_tabpage_get_number(tab)
              local cwd = vim.fn.fnamemodify(vim.fn.getcwd(-1, tabnr), ':p'):gsub('/$', '')
              if cwd == target then
                return tabnr
              end
            end
          end

          -- Helper function to switch project and reinitialize harpoon
          local function switch_project(picker, item, callback)
            picker:close()

            -- Sync harpoon BEFORE changing directory so current project's data is saved to disk
            local ok, harpoon = pcall(require, 'harpoon')
            if ok then
              harpoon:sync()
            end

            local existing = find_project_tab(item.file)
            if existing then
              -- Project is already open: jump to its tab, it already has the right tcd
              vim.cmd(existing .. 'tabnext')
            else
              -- Open the project in its own tab with a tab-local cd
              vim.cmd 'tabnew'
              vim.cmd('tcd ' .. vim.fn.fnameescape(item.file))
            end
            -- Name the tab so the tabline shows the project instead of the buffer
            vim.t.project_name = item.text == '(root)' and vim.fn.fnamemodify(item.file, ':t') or item.text
            vim.notify('Switched to: ' .. item.text, vim.log.levels.INFO)

            vim.schedule(function()
              if ok then
                -- Read new project's data and merge into existing data object
                -- so all tabs' project data coexists in memory
                local Data = require 'harpoon.data'
                local new_data = Data.Data:new(harpoon.config)
                for k, v in pairs(new_data._data) do
                  harpoon.data._data[k] = v
                end
                -- Clear cached lists so they get re-decoded from the merged data
                harpoon.lists = {}
              end

              if callback then
                vim.defer_fn(callback, 50)
              end
            end)
          end

          Snacks.picker {
            title = 'Switch Project in Tab (<CR> Switch, <C-e> Explorer, <C-h> Harpoon, <C-f> Files)',
            items = items,
            format = function(item)
              return { { item.text } }
            end,
            win = {
              input = {
                keys = {
                  ['<C-e>'] = { 'confirm_explorer', mode = { 'i', 'n' } },
                  ['<C-h>'] = { 'confirm_harpoon', mode = { 'i', 'n' } },
                  ['<C-f>'] = { 'confirm_files', mode = { 'i', 'n' } },
                },
              },
            },
            actions = {
              confirm_explorer = function(picker, item)
                switch_project(picker, item, function()
                  vim.cmd('e ' .. vim.fn.fnameescape(item.file))
                end)
              end,
              confirm_harpoon = function(picker, item)
                switch_project(picker, item, function()
                  local harpoon_ok, harpoon = pcall(require, 'harpoon')
                  if harpoon_ok then
                    harpoon.ui:toggle_quick_menu(harpoon:list())
                  else
                    Snacks.picker.files()
                  end
                end)
              end,
              confirm_files = function(picker, item)
                switch_project(picker, item, function()
                  Snacks.picker.smart { filter = { cwd = true } }
                end)
              end,
            },
            confirm = function(picker, item)
              -- Just move to the project's tab; no buffer/picker follow-up
              switch_project(picker, item)
            end,
          }
        end,
        desc = 'Switch Project',
      },
    }
  end,
}
