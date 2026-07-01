local telescope_plugins = {
  Gh 'nvim-lua/plenary.nvim',
  Gh 'nvim-telescope/telescope.nvim',
  Gh 'nvim-telescope/telescope-ui-select.nvim',
  Gh 'mollerhoj/telescope-recent-files.nvim',
}
if vim.fn.executable 'make' == 1 then table.insert(telescope_plugins, Gh 'nvim-telescope/telescope-fzf-native.nvim') end
vim.pack.add(telescope_plugins)

local actions = require 'telescope.actions'

require('telescope').setup {
  defaults = {
    path_display = function(_, path)
      local width = vim.api.nvim_get_option_value('columns', {})
      local max = math.floor(width * 0.4)

      if #path <= max then return path end

      return '…' .. path:sub(#path - max + 2)
    end,
    mappings = {
      i = {
        ['<c-enter>'] = 'to_fuzzy_refine',
        ['<c-j>'] = actions.move_selection_next,
        ['<c-k>'] = actions.move_selection_previous,
        -- ['<esc>'] = actions.close,
      },
      n = {
        ['<c-j>'] = actions.move_selection_next,
        ['<c-k>'] = actions.move_selection_previous,
      },
    },
  },
  pickers = {
    find_files = {
      theme = 'dropdown',
      previewer = false,
    },

    oldfiles = {
      theme = 'dropdown',
      previewer = false,
      cwd_only = true,
    },

    lsp_definitions = {
      theme = 'dropdown',
      previewer = false,
    },
  },
  extensions = {
    ['ui-select'] = { require('telescope.themes').get_dropdown() },
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
  },
}

pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')
pcall(require('telescope').load_extension, 'recent-files')

local builtin = require 'telescope.builtin'
local findFiles = function()
  local opts = require('telescope.themes').get_dropdown {
    previewer = false,
    mappings = {
      i = {
        ['<esc>'] = actions.close,
      },
    },
  }
  require('telescope').extensions['recent-files'].recent_files(opts)
end

-- find files
vim.keymap.set('n', '<C-p>', findFiles, { desc = 'Search Files' })
vim.keymap.set('n', '<M-p>', findFiles, { desc = 'Search Files' })

-- search word or grep
vim.keymap.set('n', '<C-f>', builtin.live_grep, { desc = 'Search Word in Other Files' })
vim.keymap.set(
  'n',
  '<M-f>',
  function()
    builtin.live_grep {
      grep_open_files = true,
      prompt_title = 'Live Grep in Open Files',
    }
  end,
  { desc = '[S]earch [O]pen Files' }
)

-- other
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })

vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
  callback = function(event)
    local buf = event.buf

    vim.keymap.set('n', 'grr', builtin.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' })

    vim.keymap.set('n', 'gri', builtin.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementation' })

    vim.keymap.set('n', 'grd', builtin.lsp_definitions, { buffer = buf, desc = '[G]oto [D]efinition' })

    vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, { buffer = buf, desc = 'Open Document Symbols' })

    vim.keymap.set('n', 'gW', builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = 'Open Workspace Symbols' })

    vim.keymap.set('n', 'grt', builtin.lsp_type_definitions, { buffer = buf, desc = '[G]oto [T]ype Definition' })
  end,
})

vim.keymap.set('n', '<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config', follow = true } end, { desc = '[S]earch [N]eovim files' })
